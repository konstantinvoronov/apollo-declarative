# Violations — Pending History

Project identifiers in historical excerpts were anonymized at the developer's request. These excerpts preserve technical evidence but are no longer verbatim quotations.

Project-local evidence collected by the violation skill. Collection is append-only; developer-approved harness maintenance may transfer an entry into a scoped pattern catalog and remove only the verified processed entry.

## V-20261020-104119 — Violation

- Recorded: 2026-10-20 10:41 Europe/Podgorica
- Location: lib/features/hello_apollo/presentation/screens/hello_apollo_screen.dart:17
- Type: pattern violation
- Status: unresolved

### User declaration

> ok so tu you last code update.
>
> violation:
> you missed patterns from reference application project for building pages.
> type: pattern vaiolation
>
> bed:
>
> const Scaffold(
>           body: SafeArea(
>             child: Column(
>               children: [
>                 Expanded(child: ApolloWelcome()),
>                 Padding(
>                   padding: EdgeInsets.all(16),
>                   child: Text('Hello Apollo World'),
>                 ),
>               ],
>             ),
>           ),
>         )
>
> code:
>
> the code is a little bigget but you must use AppScreenLayouts instead of Scaffold and use AppFlexibleLayouts is first main layout

### Violating code or pattern

Verified in the current Apollo screen before any correction:

```dart
        builder: (context, state) => const Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(child: ApolloWelcome()),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Hello Apollo World'),
                ),
              ],
            ),
          ),
        ),
```

### Direct violation reason from user

> you missed patterns from reference application project for building pages.

### Intended good pattern

> the code is a little bigget but you must use AppScreenLayouts instead of Scaffold and use AppFlexibleLayouts is first main layout

The developer supplied a reference application Home page example in `<developer-attachment>/Pasted text.txt`. Its representative outer composition is:

```dart
    return AppScreenLayouts.appGreenGradientScreen(
        extendBodyBehindAppBar: false,
        child:
        AppFlexibleLayouts.FixedVisibleBottomLayoutWithScrollableFlexibleContent(
```

The example confirms screen-wrapper then flexible-layout composition. Its feature-specific content and green styling are not additional approved requirements for Apollo. This is a confirmed target, not an implemented fix. Apollo's current copied screen wrapper is named `AppScreenLayout` (singular) in `lib/libs/uikit/core/presentation/widgets/layouts/app_screen_layout.dart`; the exact API adaptation remains to be reviewed, not silently renamed during collection.

### Pattern reference

Developer-identified source: reference application page-building pattern and the attached Home page example. No catalog entry or pattern ID was identified. Catalog promotion is pending separate developer-invoked maintenance; no pattern catalog was changed during collection.

## V-20261020-104259 — Violation

- Recorded: 2026-10-20 10:42 Europe/Podgorica
- Location: lib/features/hello_apollo/presentation/screens/hello_apollo_screen.dart:14
- Type: pattern violation
- Status: unresolved
- Related: V-20261020-104119 concerns screen layout composition; this record concerns Bloc composition and separate builder/listener methods.

### User declaration

> violation:
> page or sheet patterns building with block
> type: pattern violation
> bed:
>     return BlocProvider<HelloApolloCubit>(
>       create: (_) => createCubit(),
>       child: BlocBuilder<HelloApolloCubit, HelloApolloState>(
>         builder: (context, state) => const Scaffold(
>           body: SafeArea(
>             child: Column(
>               children: [
>                 Expanded(child: ApolloWelcome()),
>                 Padding(
>                   padding: EdgeInsets.all(16),
>                   child: Text('Hello Apollo World'),
>                 ),
>               ],
>             ),
>           ),
>         ),
>       ),
>     );
> good:
>   Widget build(BuildContext context) {
>     return BlocProvider<HomeCubit>(
>       create: (ctx) => di<HomeCubit>(),
>       child: Builder(
>         builder: (ctx) => BlocConsumer<HomeCubit, HomeState>(
>           builder: mainBuilder,
>           listener: mainListener,
>         ),
>       ),
>     );
>   }
>
> good: use separate mainBuilder and mainListener

### Violating code or pattern

Verified in the current Apollo screen before any correction:

```dart
    return BlocProvider<HelloApolloCubit>(
      create: (_) => createCubit(),
      child: BlocBuilder<HelloApolloCubit, HelloApolloState>(
        builder: (context, state) => const Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(child: ApolloWelcome()),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Hello Apollo World'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
```

### Direct violation reason from user

> page or sheet patterns building with block
>
> good: use separate mainBuilder and mainListener

### Intended good pattern

Developer-provided representative composition:

```dart
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (ctx) => di<HomeCubit>(),
      child: Builder(
        builder: (ctx) => BlocConsumer<HomeCubit, HomeState>(
          builder: mainBuilder,
          listener: mainListener,
        ),
      ),
    );
  }
```

> good: use separate mainBuilder and mainListener

The attached example `<developer-attachment>/Pasted text.txt` supplies separate `void mainListener(BuildContext context, HomeState state)` and `Widget mainBuilder(BuildContext context,HomeState state)` methods. The listener handles state errors; the builder composes the UI. Those Home-specific error cases and dependencies are reference evidence, not an implemented Hello Apollo correction. No change to Apollo's existing injected Cubit factory has been made or inferred solely from the example's DI expression.

### Pattern reference

Developer-identified page/sheet Bloc composition and attached reference application Home builder/listener example. No catalog entry or pattern ID was identified. The target is confirmed; implementation and separate maintenance-driven catalog promotion remain pending. No existing violation was rewritten or removed.

## V-20261020-104525 — Violation

- Recorded: 2026-10-20 10:45 Europe/Podgorica
- Location: lib/features/hello_apollo/presentation/screens/hello_apollo_screen.dart:7
- Type: pattern violation
- Status: unresolved
- Related: V-20261020-104119 covers layout composition; V-20261020-104259 covers Bloc composition. This record covers the screen/sheet declaration and result/failure contract.

### User declaration

> violation:
>
> Screen or Sheet declaration
> type pattern violation
> bed:class HelloApolloScreen extends StatelessWidget {
>   final HelloApolloCubit Function() createCubit;
> good:class HomeScreen extends StatelessWidget with EventOnSuccess<bool>,AppHandleFailure {
>   final AppOnSuccess<bool>? onSuccess;
>
> define what page return, define callback define AppHandleFailure

### Violating code or pattern

Verified in the current Apollo screen before any correction:

```dart
class HelloApolloScreen extends StatelessWidget {
  final HelloApolloCubit Function() createCubit;
```

### Direct violation reason from user

> define what page return, define callback define AppHandleFailure

### Intended good pattern

Developer-provided representative declaration:

```dart
class HomeScreen extends StatelessWidget with EventOnSuccess<bool>,AppHandleFailure {
  final AppOnSuccess<bool>? onSuccess;
```

Screens and sheets declare their result type through `EventOnSuccess<T>`, the corresponding `AppOnSuccess<T>? onSuccess` callback, and `AppHandleFailure`. The supplied example uses `bool`; Hello Apollo's particular result type has not been separately determined. This is a confirmed declaration pattern, not an implemented correction or an instruction to remove the existing Cubit factory.

### Pattern reference

Developer-identified screen/sheet declaration pattern and supplied HomeScreen example. No catalog entry or pattern ID was identified. Code changes and separate maintenance-driven catalog promotion remain pending; collection changed neither source code nor pattern catalogs.

## V-20261020-120845 — Good pattern learned

- Recorded: 2026-10-20 12:08 Europe/Podgorica
- For: V-20261020-104119
- Fixed location: lib/features/hello_apollo/presentation/screens/hello_apollo_screen.dart:40
- Verification: scoped static analysis passes; runtime layout is unverified.

### User message

> fix these in HelloApolloScreen

### Good pattern confirmed by user

> the code is a little bigget but you must use AppScreenLayouts instead of Scaffold and use AppFlexibleLayouts is first main layout

### Confirmed target or corrected code

```dart
    return AppScreenLayouts.appBasicScreen(
      child: AppFlexibleLayouts.FixedVisibleBottomLayoutWithForcedToFillContent(
```

The existing Shared AppScreenLayouts extension is used. The flexible layout keeps the welcome widget's existing scrolling and fixed greeting footer. No reference application-specific green styling or feature content was introduced.

## V-20261020-120845-2 — Good pattern learned

- Recorded: 2026-10-20 12:08 Europe/Podgorica
- For: V-20261020-104259
- Fixed location: lib/features/hello_apollo/presentation/screens/hello_apollo_screen.dart:26
- Verification: scoped static analysis passes; listener execution is unverified.

### User message

> fix these in HelloApolloScreen

### Good pattern confirmed by user

> good: use separate mainBuilder and mainListener

### Confirmed target or corrected code

```dart
    return BlocProvider<HelloApolloCubit>(
      create: (_) => createCubit(),
      child: Builder(
        builder: (ctx) => BlocConsumer<HelloApolloCubit, HelloApolloState>(
          builder: mainBuilder,
          listener: mainListener,
        ),
      ),
    );
```

Both named methods are declared on the screen. The listener is empty because the current example State has no errors or effects. The injected Cubit factory and provider lifecycle were preserved.

## V-20261020-120845-3 — Good pattern learned

- Recorded: 2026-10-20 12:08 Europe/Podgorica
- For: V-20261020-104525
- Fixed location: lib/features/hello_apollo/presentation/screens/hello_apollo_screen.dart:11
- Verification: scoped static analysis passes; success callbacks and failure handling were not runtime-tested.

### User message

> fix these in HelloApolloScreen

### Good pattern confirmed by user

> define what page return, define callback define AppHandleFailure

### Confirmed target or corrected code

```dart
class HelloApolloScreen extends StatelessWidget
    with EventOnSuccess<bool>, AppHandleFailure {
  final HelloApolloCubit Function() createCubit;
  final AppOnSuccess<bool>? onSuccess;
```

```dart
  @override
  AppOnSuccess<bool>? get getOnSuccess => onSuccess;
```

AppHandleFailure is imported from its project-local Shared adaptation, not directly from the protected blueprint. The adaptation uses Apollo's existing logger interface registration and the original snackbar behavior with a call-local BuildContext. Its original comments and failure-policy branches are preserved. No artificial failure State was added to invoke the handler in the otherwise empty example.

These linked records describe implemented source corrections, not catalog promotion, runtime verification, or deletion of the original evidence. The Shared destination wording conflict noted in implementation_plan.md remains a separate declaration-review issue.

## V-20261020-121439 — Violation

- Recorded: 2026-10-20 12:14 Europe/Podgorica
- Location: lib/features/hello_apollo/presentation/screens/hello_apollo_screen.dart:38
- Related locations: lib/features/hello_apollo/presentation/controllers/hello_apollo_cubit.dart; lib/features/hello_apollo/presentation/controllers/hello_apollo_state.dart
- Type: pattern violation
- Status: unresolved
- Related: V-20261020-104259 covers separate builder/listener declarations. This distinct record requires actual controller-error processing even for a blank controller. It corrects the earlier agent assumption that an empty example justifies an empty listener.

### User declaration

Verbatim supplied message, retaining its markup/escaping:

````text
violation:
no error processing handler from controller
type: pattern violtion

bed:
&#x20; void mainListener(BuildContext context, HelloApolloState state) {}\
good:

final cubit = context.read\<HomeCubit>();\
\
for (var error in state.errors.entries) {\
&#x20; *// validation error processed in ui*\&#xA;*&#x20;&#x20;*&#x69;f (error.value is ValidationFailure) continue;\
&#x20; switch (error.key) {\
&#x20;   case (HomeErrorType.unhandledError):\
&#x20;   default:\
&#x20;     final failure = error.value;\
&#x20;     uiFailureHandler(\
&#x20;       context: context,\
&#x20;       failure: failure,\
&#x20;       fallback: () {\
&#x20;         HapticFeedback.*lightImpact*();\
&#x20;       },\
&#x20;       clearUnhandledError: () => cubit.clearUnhandledError(error.key),\
&#x20;     );\
&#x20; }\
}

for any even blacnk controller we should decleara error processing patterns\
````

### Violating code or pattern

Verified in the current screen before any correction:

```dart
  void mainListener(BuildContext context, HelloApolloState state) {}
```

The current HelloApolloState has only its initial constructor and empty Equatable props, and HelloApolloCubit has only its initial-state constructor. Neither currently declares the error map or clearUnhandledError operation used in the supplied pattern.

### Direct violation reason from user

> no error processing handler from controller

> for any even blacnk controller we should decleara error processing patterns\

### Intended good pattern

Representative code from the supplied example, with HTML entities and formatting escapes decoded for readability (Home-specific names retained):

```dart
final cubit = context.read<HomeCubit>();

for (var error in state.errors.entries) {
  // validation error processed in ui
  if (error.value is ValidationFailure) continue;
  switch (error.key) {
    case (HomeErrorType.unhandledError):
    default:
      final failure = error.value;
      uiFailureHandler(
        context: context,
        failure: failure,
        fallback: () {
          HapticFeedback.lightImpact();
        },
        clearUnhandledError: () => cubit.clearUnhandledError(error.key),
      );
  }
}
```

The developer requires the error-processing pattern even for a blank controller: declared controller State errors and a clearing operation, plus listener processing that leaves validation errors to the UI and passes other errors to uiFailureHandler with fallback and clearing callbacks. This is a confirmed intended pattern, not an implemented fix. Hello Apollo-specific declarations and implementation remain pending.

### Pattern reference

Developer-provided Home listener/controller-error processing example in this message. No catalog entry or pattern ID was identified. Collection did not change code, existing records, pattern catalogs, or the pending snackbar DI proposal. The previous agent rationale about avoiding error scaffolding for blank controllers is not a developer-approved exemption.

## V-20261020-121716 — Violation

- Recorded: 2026-10-20 12:17 Europe/Podgorica
- Location: lib/features/hello_apollo/presentation/controllers/hello_apollo_state.dart:3
- Type: pattern violation
- Status: unresolved
- Related: V-20261020-121439 requires error processing in the controller/listener. This record defines the required declarative State shape, including status and error enums, fields, copying, and equality.

### User declaration

````text
violation:
blank controller without declerative elements.
type: pattern violation

bed :

class HelloApolloState extends Equatable {
  const HelloApolloState.initial();

  @override
  List<Object?> get props => const [];
}

good code:


enum HomeStatus { initialize, ready }
enum HomeErrorType { unhandledError }

@immutable
class HomeState extends Equatable{
  final HomeStatus status;
  final int displayBalance;
  final Map<HomeErrorType,AppFailure> errors;

  HomeState({required this.status,this.errors = const {},this.displayBalance = 0,});

  factory HomeState.initial() => HomeState(status: HomeStatus.initialize);

  HomeState copyWith({
    HomeStatus? status,
    int? displayBalance,
    Map<HomeErrorType, AppFailure>? errors,
  }) {
    return HomeState(
      status: status ?? this.status,
      displayBalance: displayBalance ?? this.displayBalance,
      errors: errors ?? this.errors,
    );
  }

  @override
  List<Object?> get props => [errors,displayBalance,status];

}

must be present controller state enum and error enum with defulat errors:

enum HomeStatus { initialize, ready }
enum HomeErrorType { unhandledError }

must be declared containers for it in state :

  final HomeStatus status;
  final Map<HomeErrorType,AppFailure> errors;


must present copyWith and props
````

### Violating code or pattern

Verified in the current State before any correction:

```dart
class HelloApolloState extends Equatable {
  const HelloApolloState.initial();

  @override
  List<Object?> get props => const [];
}
```

### Direct violation reason from user

> blank controller without declerative elements.

> must be present controller state enum and error enum with defulat errors:

> must be declared containers for it in state :

> must present copyWith and props

### Intended good pattern

The complete developer-supplied HomeState example is preserved above. Its required declarations are:

```dart
enum HomeStatus { initialize, ready }
enum HomeErrorType { unhandledError }
```

```dart
  final HomeStatus status;
  final Map<HomeErrorType,AppFailure> errors;
```

Even a blank controller has a declarative immutable State with a status enum containing initialize/ready, an error enum containing unhandledError, matching status and AppFailure-map fields, an initial state selecting initialize and empty errors, copyWith, and Equatable props covering its fields. These requirements are confirmed by the developer; their Hello Apollo implementation is pending. Home names are representative, and displayBalance is Home-specific example data, not a requirement to add balance functionality to Hello Apollo.

### Pattern reference

Developer-provided declarative controller-State example in this message. No existing catalog entry or pattern ID was identified. This is collected violation evidence and a confirmed intended pattern, not a catalog update, source correction, or approval of the pending snackbar DI wiring proposal. No prior records were rewritten or removed.

## V-20261020-122001 — Good pattern learned

- Recorded: 2026-10-20 12:20 Europe/Podgorica
- For: V-20261020-121439
- Related: V-20261020-121716 defines the required State error map and enum.
- Affected location: lib/features/hello_apollo/presentation/controllers/hello_apollo_cubit.dart:6
- Fixed location: pending
- Status: confirmed target; not implemented

### User message

````text
violation: basic controller doesnt decleare error processing path..
type:pattern_violation:
bed:
class HelloApolloCubit extends Cubit<HelloApolloState> {
  HelloApolloCubit() : super(const HelloApolloState.initial());
}
good:

  void clearUnhandledError(HomeErrorType? err) {
    emit(state.copyWith(errors: {...state.errors}..remove(err ?? HomeErrorType.unhandledError)));
  }
````

### Violating code or pattern

Verified before any correction:

```dart
class HelloApolloCubit extends Cubit<HelloApolloState> {
  HelloApolloCubit() : super(const HelloApolloState.initial());
}
```

### Direct violation reason from user

> basic controller doesnt decleare error processing path..

### Good pattern confirmed by user

```dart
  void clearUnhandledError(HomeErrorType? err) {
    emit(state.copyWith(errors: {...state.errors}..remove(err ?? HomeErrorType.unhandledError)));
  }
```

### Confirmed target or corrected code

The supplied method is the confirmed target: copy the State error map, remove the supplied key or default unhandledError key when the argument is null, then emit the copied State. The supplied HomeErrorType is representative; the Hello Apollo implementation remains pending. The original map is not mutated.

The earlier V-20261020-121439 already records the missing controller clearing operation as part of the error-processing path. This follow-up preserves the newly supplied exact Cubit evidence and confirmed method without creating a duplicate violation. No code, catalogs, or existing records were changed or removed.

## V-20261020-122116 — Good pattern learned

- Recorded: 2026-10-20 12:21 Europe/Podgorica
- For: V-20261020-121716
- Fixed location: lib/features/hello_apollo/presentation/controllers/hello_apollo_state.dart:3
- Verification: scoped analysis and formatting pass; State lifecycle/equality behavior was not runtime-tested.

### User message

> fix that violations.

### Good pattern confirmed by user

> must be present controller state enum and error enum with defulat errors:

> must be declared containers for it in state :

> must present copyWith and props

### Confirmed target or corrected code

```dart
enum HelloApolloStatus { initialize, ready }

enum HelloApolloErrorType { unhandledError }

@immutable
class HelloApolloState extends Equatable {
  final HelloApolloStatus status;
  final Map<HelloApolloErrorType, AppFailure> errors;

  const HelloApolloState({required this.status, this.errors = const {}});

  factory HelloApolloState.initial() =>
      const HelloApolloState(status: HelloApolloStatus.initialize);

  HelloApolloState copyWith({
    HelloApolloStatus? status,
    Map<HelloApolloErrorType, AppFailure>? errors,
  }) {
    return HelloApolloState(
      status: status ?? this.status,
      errors: errors ?? this.errors,
    );
  }

  @override
  List<Object?> get props => [errors, status];
}
```

Home-specific displayBalance was not copied. No automatic ready transition was invented for the otherwise empty feature.

## V-20261020-122116-2 — Good pattern learned

- Recorded: 2026-10-20 12:21 Europe/Podgorica
- For: V-20261020-121439
- Related confirmed method: V-20261020-122001
- Fixed locations: lib/features/hello_apollo/presentation/controllers/hello_apollo_cubit.dart:11; lib/features/hello_apollo/presentation/screens/hello_apollo_screen.dart:40
- Verification: scoped analysis and formatting pass; UI notification, haptic feedback, and clearing emissions were not runtime-tested.

### User message

> fix that violations.

### Good pattern confirmed by user

> for any even blacnk controller we should decleara error processing patterns\

> basic controller doesnt decleare error processing path..

### Confirmed target or corrected code

```dart
  void clearUnhandledError(HelloApolloErrorType? err) {
    emit(
      state.copyWith(
        errors: {...state.errors}
          ..remove(err ?? HelloApolloErrorType.unhandledError),
      ),
    );
  }
```

```dart
  void mainListener(BuildContext context, HelloApolloState state) {
    final cubit = context.read<HelloApolloCubit>();

    for (var error in state.errors.entries) {
      // validation error processed in ui
      if (error.value is ValidationFailure) continue;
      switch (error.key) {
        case HelloApolloErrorType.unhandledError:
          final failure = error.value;
          uiFailureHandler(
            context: context,
            failure: failure,
            fallback: () {
              HapticFeedback.lightImpact();
            },
            clearUnhandledError: () => cubit.clearUnhandledError(error.key),
          );
      }
    }
  }
```

The original error map is copied before removal. The sole declared error key is handled exhaustively, and ValidationFailure remains skipped as in the developer's example. No artificial error-producing operation was added. The failure handler still resolves AppSnackBar through DI using the shared global navigator key. These are implemented source corrections; original evidence stays in the pending history and no pattern catalog was changed.

## V-20261020-132621 — Violation

- Recorded: 2026-10-20 13:26 Europe/Podgorica
- Location: lib/features/hello_apollo/presentation/screens/hello_apollo_screen.dart:70
- Type: pattern violation
- Status: unresolved

### User declaration

````text
violation
type: pattern violation

bed code:
Text('Hello Apollo World')
good code:
"loading".tr().p4()

use localization and style applying patterns
````

### Violating code or pattern

Developer-identified form:

```dart
Text('Hello Apollo World')
```

Verified current form before any correction (centering does not address the localization/typography omission):

```dart
              child: Text('Hello Apollo World', textAlign: TextAlign.center),
```

### Direct violation reason from user

> use localization and style applying patterns

### Intended good pattern

Developer-confirmed representative example:

```dart
"loading".tr().p4()
```

Localize the text and then render it through the project typography extension rather than using raw, unlocalized Text. The loading string illustrates the localization/style chain; it is not an instruction to replace the Hello Apollo World greeting with loading. Preserve the previously requested centering when implementing this correction. This is a confirmed target, not an implemented fix; broader catalog scope or changes to other text are not inferred from collection.

### Pattern reference

Developer-provided localization-then-typography example in this message. No existing catalog entry or pattern ID was identified. No source, existing records, pattern catalogs, or harness rules changed during this collection step.

## V-20261020-132824 — Good pattern learned

- Recorded: 2026-10-20 13:28 Europe/Podgorica
- For: V-20261020-132621
- Fixed location: lib/features/hello_apollo/presentation/screens/hello_apollo_screen.dart:72
- Translation: assets/translations/en.json, hello_apollo.greeting
- Verification: scoped analysis, formatting, and git diff --check pass; no runtime rebuild/reload or new screenshot was performed for this change.

### User message

> fix lates pattern violations

### Good pattern confirmed by user

```dart
"loading".tr().p4()
```

> use localization and style applying patterns

### Confirmed target or corrected code

```dart
              child: 'hello_apollo.greeting'.tr().p4(
                textAlign: TextAlign.center,
              ),
```

The existing English asset defines hello_apollo.greeting as Hello Apollo World. The greeting remains inside its Center wrapper, with centered text alignment and existing footer padding. The developer's loading text was treated as a representative chain, not substituted for the greeting. Runtime localization makes the footer widget list non-const; fixed padding remains const. Original evidence is retained, and no catalog, protected library, or unrelated text was changed.

## V-20261021-040020 — Violation

- Recorded: 2026-10-21 04:00 Europe/Podgorica
- Location: lib/core/presentation/widgets/apollo_welcome.dart:70
- Type: pattern violation
- Status: unresolved

### User declaration

````text
violation:
type: pattern violation

text formatting violation

bed:

Text(
                    context.tr(
                      'apollo_welcome.build_info',
                      namedArgs: {'version': version, 'build': buildNumber},
                    ),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),

good: 'apollo_welcome.build_info'.tr().p4()

must use predefined string extensions and internaionalization
````

### Violating code or pattern

```dart
Text(
  context.tr(
    'apollo_welcome.build_info',
    namedArgs: {'version': version, 'build': buildNumber},
  ),
  textAlign: TextAlign.center,
  style: theme.textTheme.bodySmall?.copyWith(
    color: theme.colorScheme.onSurfaceVariant,
  ),
)
```

### Direct violation reason from user

> must use predefined string extensions and internaionalization

### Intended good pattern

```dart
'apollo_welcome.build_info'.tr().p4()
```

This is the developer-confirmed representative chain. The implemented correction remains pending; the version/build interpolation and existing tap interaction remain part of the active feature requirements.

### Pattern reference

Related earlier declaration: V-20261020-132621, localization followed by predefined typography. This record captures a new occurrence in ApolloWelcome, where localization exists but rendering uses manual Text styling. Catalog entry remains unresolved; collection preserves catalogs and prior history.

## V-20261021-040127 — Good pattern learned

- Recorded: 2026-10-21 04:01 Europe/Podgorica
- For: V-20261021-040020
- Fixed location: lib/core/presentation/widgets/apollo_welcome.dart:71
- Verification: scoped Dart analysis reports no issues; git diff --check passes. Runtime appearance remains unverified.

### User message

> aprove. use this code in violation history as good code

### Good pattern confirmed by user

The developer approved the proposed localization/typography chain with named arguments and centered alignment.

### Confirmed target or corrected code

```dart
'apollo_welcome.build_info'
    .tr(namedArgs: {'version': version, 'build': buildNumber})
    .p4(textAlign: TextAlign.center)
```

Applied through the existing UIKit StringTextExtensions import. The version/build values, GestureDetector, and onVersionTap callback are preserved. Earlier violation evidence and pattern catalogs retain their contents.
