# Error Handling Architecture Manual

> Historical Reference application reference, superseded by [Apollo AppFailure usage rules](../../../ai_development/app_failure_usage_rules.md). Do not use the legacy `Either`, local failure definitions, or factory names below for Apollo code. Apollo uses `package:app_failure/app_failure.dart` and `AppResult<T>`; its `fold` takes success first, then failure.

This document outlines the structure, flow, and principles behind the app's error processing mechanism. It is designed for clarity, reliability, and separation of concerns.

---

## 🔹 Core Principles

- **Errors originate from deep layers and travel outward**
- **UI is the only layer that reacts to errors for user interaction**
- **System-wide crashes are exceptions, handled via fallback**
- **Use ****************************************************`AppLogger.bm()`**************************************************** for benchmarking long operations**

---

## 1. Error Propagation Flow

### Concept

- All logical failures are represented as `Either<AppFailure, T>`
- `AppFailure` captures the cause, severity, and stack trace
- Only the **UI layer** decides how to react
- Unknown exceptions are thrown via `throw(AppFailure.unhandledException(e, st))`
- Caught globally in `AppGlobalErrorHandlers.handleZonedError`

### Rule

> Errors are **not thrown directly** from inner layers to UI.
> Instead, use `Either` and let the outermost layer fold and react.

---

## 2. Declearing in Managers or Usecases with `AppFailure`

Use `fold()` or `match()` in Cubit/Controller:

```dart
final result = await SomeUseCase();
result.fold(
  (failure) => emit(state.copyWith(status: Status.unhandledError, failure: failure)),
  (data) => emit(state.copyWith(...))
);
```

### Example: Repository Implementation
#### Use void wrapper executeApiCallWithVoidResponse

```dart
Future<Either<AppFailure, void>> updateLastReadTime(String orderId, String messageId) async {
  try {
    return executeApiCallWithVoidResponse(
      handleName: "_apiP2E.markLastReadMessage",
      apiCall: () async => _apiP2E.markLastReadMessage(orderId: orderId, messageId: messageId),
    );
  } catch (error, st) {
    return Left(AppFailure.unhandledException(error: error, stackTrace: st));
  }
}


```

#### or Response wrapper executeApiCall

```dart


Future<Either<AppFailure, List<P2EChatMessageModel>>> getOrderMessages(String orderId) async {
  try {
    return executeApiCall<P2EOrderChatMessagesWithPagingDTO,List<P2EChatMessageModel>>(
      handleName: "_apiP2E.markLastReadMessage",
      apiCall: () async => _apiP2E.getP2EOrderChatMessages(orderId: orderId, pageNumber: 1, pageSize: 1000),
      responseMapper: (response) {
        return response.items.map((e) => P2EChatMessageModel.fromDTO(e)).toList();
      },
    );
  } catch (error, st) {
    return Left(AppFailure.unhandledException(logMessage:'getOrderMessages failed',error: error, stackTrace: st));
  }
}
#### Use custom processing 

```dart
Future<Either<AppFailure, List<CountryModel>>> getCountriesWithCities() async {
  try {
    final response = await _apiGeo.getAllCitiesGroupedByCountry();
    if (response.statusCode != null && response.statusCode! < 300) {
      return Right(response.data!.map(CountryModel.fromCountryWithCitiesDTO).toList());
    } else {
      return Left(AppFailure.unexpectedNetworkResponse(response, StackTrace.current));
    }
  } catch (e, st) {
    return Left(AppFailure.apiException(e: error, stackTrace: st));
  }
}
```

or 

```dart
  try {
    final pricing = (await account.fetchPricing()).fold((failure) => throw(failure), (value)=>value);
  } catch (error,st){
    return Either<UseCaseError, void>.left(your AppFailure.controllerException(
      uiMessage: 'Couldn\'t save verified phone. please verify again',
      logMessage: 'SetVerifiedPhoneUseCase failed',
      cause: (error is AppFailure) ? e as AppFailure : AppFailure.unhandledException(e: error, stackTrace: st),
      fatalLevel: FatalLevel.featureFatal,
      e: error, stackTrace: StackTrace.current));
  }
```


---

## 3. UI Layer: Controller + BlocConsumer

### Step 1: Creating Controller in the UI

```dart
BlocProvider(
  create: (_) => CitiesCubit(),
  child: BlocConsumer<CitiesCubit, CitiesState>(
    builder: buildMain,
    listenWhen: (a,b) => a.errors != b.errors,
    listener: mainListener,
  ),
);
```

### Step 2: Process error in build layout

```dart
Widget buildMain(BuildContext context, CitiesState state) {
  return OrderDeliveryType.delivery.getText.p2(color: (state.errors.containsKey(P2eErrorType.obtain) ? uiTheme.colors.redPrimary : null );// build UI
}
```

or 

```dart
Widget buildMain(BuildContext context, CitiesState state) {
  return Column(children: [
    if(state.errors.containsKey(SendCryptoErrorTypes.couldntCalculateNetworkFee))
      ((state.errors[SendCryptoErrorTypes.couldntCalculateNetworkFee] as AppFailure).uiMessage ??
          '').p1(color: uiTheme.colors.redPrimary)
  ]);
}
```


### Step 3: Handle Custom and global Errors via Listener using HandleFailure from AppHandleFailure mixin 

> 💡 In state define enum error:

```dart
enum CitiesControllerErrorType { unhandledError, }

final Map<CitiesControllerErrorType, AppFailure> errors;
```




```dart
void mainListener(BuildContext context, CitiesState state) {
  for (var error in state.errors.entries) {
    // validation error processed in ui
    if (error.value.type == FailureType.validation) continue;
    switch (error) {
      case(SendCryptoErrorTypes.unhandledError):
      default:
        final failure = error.value;
        uiFailureHandler(
          context: context,
          failure: failure!,
          fallback: () {
            HapticFeedback.lightImpact();
          },
          clearUnhandledError: () => context.read<SendCryptoCubit>().clearUnhandledError(error.key),
        );
    }
  }
}
```

> 💡 In Controller you can make to avoid doubling logging of error:

```dart
void clearUnhandledError(SendCryptoErrorTypes? err) {
  emit(state.copyWith(errors: {...state.errors}..remove(err ?? SendCryptoErrorTypes.unhandledError)));
}

```

---

## 4. Error Maps in Controllers and State

### Define Error Types

```dart
enum ScreenControllerErrorType {
  errorSendingMessage,
  errorUpdatingMessages,
  unhandledError,
}
```

### Use in State

```dart
final Map<ScreenControllerErrorType, AppFailure> errors;
```

### Emit Errors

```dart
res.match(
  (failure) => emit(state.copyWith(errors: {
    ...state.errors,
    CitiesControllerErrorType.unhandledError: failure,
  })),
  (data) => emit(state.copyWith(...)),
);
```

---

## 5. Logging Failures

### Log Failures

```dart
AppLogger().logFailure(failure, context: 'SomeContext');
```

### Log Zones

```dart
FlutterError.onError = (FlutterErrorDetails details) {
  AppLogger().log('FlutterError: ${details.exceptionAsString()}');
  FlutterError.dumpErrorToConsole(details);
};

runZonedGuarded(() async {
  runApp(MyApp());
}, (Object error, StackTrace stack) {
  AppLogger().logFailure(AppFailure.unhandledException(error, stack));
});
```

---

## 6. Benchmarking Operations

### Usage

```dart
final result = await AppLogger().bm(
  someAsyncOperation(),
  id: 'loadUserProfile',
);
```

> Logs duration and triggers performance alert if threshold exceeded

---

## 7. Crash Safety & Recovery

### Detect Previous Crash

```dart
if (await FileLogger().wasLastSessionCrash()) {
  // Show UI or upload logs
}
```

### Mark Clean Exit

```dart
await FileLogger().markCleanExit();
```

### On Resume

```dart
await FileLogger().unmarkCleanExit();
```

### Upload Logs

```dart
await FileLogger().uploadLogFile();
```

### User-Facing Report Dialog

```dart
showReportErrorDialog();
```

---

## 8. Summary & Best Practices

✅ Use `Either<AppFailure, T>` in all logic/data layers\
✅ Only UI handles the `AppFailure`\
✅ Use `AppHandleFailure` to standardize reactions\
✅ Log non-fatal issues with context using `AppLogger.logFailure()`\
✅ Wrap operations in `AppLogger.bm()` for tracing\
✅ Use global handlers for crash fallback & session recovery

> **Errors are data, not control flow.**


### Current refactor steps:

> Instead of this:

```dart
showToast('$e');
```

```dart
throw e is AppFailure ? e : AppFailure.unhandledException(e: error, stackTrace: st);
```

> or increase fatality:

```dart
throw e is AppFailure ? e.copyWith(fatalLevel: FatalLevel.featureFatal) : AppFailure.usecaseException(e: error, stackTrace: st,fatalLevel: FatalLevel.featureFatal);
```

> next step refactor -> make function return instead of throw

```dart
return Either<AppFailure, FeeRecommendations>.left(e is AppFailure ? e.copyWith(fatalLevel: FatalLevel.featureFatal) : AppFailure.usecaseException(e: error, stackTrace: st));
```

> semi refactor for api managers


```dart
Future<int> getUserAMLBalance() async {
  try {
    final response = await _amlApi.getDeviceAMLBalance();
    if (response.data != null) {
      return response.data!.balance;
    }
  } on DioException catch (e) {
    log('$e');
    showToast('$e');
  }
  return 0;
}
```

```dart
Future<int> getUserAMLBalance() async {
  try {
    final response = await _amlApi.getDeviceAMLBalance();
    if (response.data != null) {
      return response.data!.balance;
    }
  } catch(error,st){
    throw AppFailure.apiException(
        logMessage: '_apiCredit.performCredit failure',
        cause: error, // больше никакой расшифровки не надо все внутри
        /*
            (error is AppFailure)
            ? error as AppFailure
            : (error is DioException)
            ? AppFailure.dioException(error: error, stackTrace: StackTrace.current)
            : AppFailure.unhandledException(error: error, stackTrace: st),        
         */
        fatalLevel: FatalLevel.notFatal,
        error: error, stackTrace: StackTrace.current);
  }
  return 0;
}
```

