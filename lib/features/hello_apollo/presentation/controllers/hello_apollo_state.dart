part of 'hello_apollo_cubit.dart';

enum HelloApolloStatus { initialize, ready }

enum HelloApolloErrorType { unhandledError }

@immutable
class HelloApolloState extends Equatable {
  final HelloApolloStatus status;
  final Map<HelloApolloErrorType, AppFailure> errors;

  const HelloApolloState({
    required this.status,
    this.errors = const {},
  });

  factory HelloApolloState.initial() =>
      HelloApolloState(status: HelloApolloStatus.initialize);

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
