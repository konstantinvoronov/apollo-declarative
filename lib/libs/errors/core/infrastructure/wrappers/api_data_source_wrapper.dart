import 'package:app_failure/app_failure.dart';
import 'package:dio/dio.dart';

Future<AppResult<ResultT>> apiDataSourceWrapper<ResponseT, ResultT>({
  required Future<Response<ResponseT>> Function() apiCall,
  required String? handleName,
  required ResultT Function(ResponseT response) responseMapper,
}) async {
  try {
    final response = await apiCall();

    if (response.isSuccessful) {
      if (response.data == null) {
        return AppResult.failure(
          AppFailure.apiFailure(
            logMessage: 'Unexpected empty response from $handleName $response',
            request: _requestModel(response.requestOptions),
            response: _responseModel(response),
            stackTrace: StackTrace.current,
          ),
        );
      }
      return AppResult.success(responseMapper(response.data as ResponseT));
    }

    return AppResult.failure(
      _failureForUnexpectedResponse(response, handleName),
    );
  } catch (error, st) {
    return AppResult.failure(_apiFailureFor(error, st, handleName));
  }
}

Future<AppResult<void>> apiWithVoidResponseDataSourceWrapper({
  required Future<Response<void>> Function() apiCall,
  required String? handleName,
}) async {
  try {
    final response = await apiCall();

    if (response.isSuccessful) {
      return const AppResult.success(null);
    }

    return AppResult.failure(
      _failureForUnexpectedResponse(response, handleName),
    );
  } catch (error, st) {
    return AppResult.failure(_apiFailureFor(error, st, handleName));
  }
}

AppFailure _failureForUnexpectedResponse(
  Response<dynamic> response,
  String? handleName,
) {
  final stackTrace = StackTrace.current;
  return AppFailure.apiFailure(
    uiMessage: 'Wrong server response',
    logMessage: 'Wrong $handleName response',
    cause: AppFailure.httpFailure(
      request: _requestModel(response.requestOptions),
      response: _responseModel(response),
      failureKind: HttpFailureKind.badResponse,
      stackTrace: stackTrace,
    ),
    stackTrace: stackTrace,
  );
}

AppFailure _apiFailureFor(
  Object error,
  StackTrace stackTrace,
  String? handleName,
) {
  final Object cause;
  if (error is DioException) {
    cause = AppFailure.httpFailure(
      request: _requestModel(error.requestOptions),
      response: error.response == null ? null : _responseModel(error.response!),
      failureKind: switch (error.type) {
        DioExceptionType.connectionTimeout => HttpFailureKind.connectionTimeout,
        DioExceptionType.sendTimeout => HttpFailureKind.sendTimeout,
        DioExceptionType.receiveTimeout => HttpFailureKind.receiveTimeout,
        DioExceptionType.badCertificate => HttpFailureKind.badCertificate,
        DioExceptionType.badResponse => HttpFailureKind.badResponse,
        DioExceptionType.cancel => HttpFailureKind.cancelled,
        DioExceptionType.connectionError => HttpFailureKind.connectionError,
        DioExceptionType.unknown => HttpFailureKind.unknown,
      },
      cause: error.error is AppFailure ? error.error as AppFailure : null,
      error: error,
      debugDescription: error.toString(),
      stackTrace: stackTrace,
    );
  } else {
    cause = error;
  }
  return AppFailure.apiFailure(
    logMessage: '$handleName failed',
    cause: cause,
    stackTrace: stackTrace,
  );
}

HttpFailureRequestModel _requestModel(RequestOptions request) =>
    HttpFailureRequestModel(
      method: request.method,
      uri: request.uri,
      headers: request.headers,
      body: request.data,
    );

HttpFailureResponseModel _responseModel(Response<dynamic> response) =>
    HttpFailureResponseModel(
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      headers: response.headers.map,
      body: response.data,
    );

extension ResponseExt on Response {
  bool get isSuccessful =>
      statusCode != null && statusCode! >= 200 && statusCode! < 300;
}
