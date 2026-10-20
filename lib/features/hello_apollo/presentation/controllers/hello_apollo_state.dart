part of 'hello_apollo_cubit.dart';

enum HelloApolloStatus { initialize, ready }

enum HelloApolloErrorType { unhandledError }

@immutable
class HelloApolloState extends Equatable {
  final HelloApolloStatus status;
  final String version;
  final String buildNumber;
  final Map<HelloApolloErrorType, AppFailure> errors;

  const HelloApolloState({
    required this.status,
    required this.version,
    required this.buildNumber,
    this.errors = const {},
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
  }) {
    return HelloApolloState(
      status: status ?? this.status,
      version: version,
      buildNumber: buildNumber,
      errors: errors ?? this.errors,
    );
  }

  @override
  List<Object?> get props => [errors, status, version, buildNumber];
}
