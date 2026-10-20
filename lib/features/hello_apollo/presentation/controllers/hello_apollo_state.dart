part of 'hello_apollo_cubit.dart';

enum HelloApolloStatus { initialize, ready }

enum HelloApolloErrorType { unhandledError }

enum HelloApolloSheetResult { none, confirmed, cancelled }

@immutable
class HelloApolloState extends Equatable {
  final HelloApolloStatus status;
  final String version;
  final String buildNumber;
  final Map<HelloApolloErrorType, AppFailure> errors;
  final HelloApolloSheetResult sheetResult;

  const HelloApolloState({
    required this.status,
    required this.version,
    required this.buildNumber,
    this.errors = const {},
    this.sheetResult = HelloApolloSheetResult.none,
  });

  factory HelloApolloState.initial({
    required String version,
    required String buildNumber,
  }) => HelloApolloState(
    status: HelloApolloStatus.initialize,
    version: version,
    buildNumber: buildNumber,
  );

  HelloApolloState copyWith({
    HelloApolloStatus? status,
    Map<HelloApolloErrorType, AppFailure>? errors,
    HelloApolloSheetResult? sheetResult,
  }) {
    return HelloApolloState(
      status: status ?? this.status,
      version: version,
      buildNumber: buildNumber,
      errors: errors ?? this.errors,
      sheetResult: sheetResult ?? this.sheetResult,
    );
  }

  @override
  List<Object?> get props => [errors, status, version, buildNumber, sheetResult];
}
