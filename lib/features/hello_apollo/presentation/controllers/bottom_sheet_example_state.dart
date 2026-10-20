part of 'bottom_sheet_example_cubit.dart';

enum BottomSheetExampleStatus { initialize, ready }

enum BottomSheetExampleErrorType { unhandledError }

@immutable
class BottomSheetExampleState extends Equatable {
  final BottomSheetExampleStatus status;
  final Map<BottomSheetExampleErrorType, AppFailure> errors;

  const BottomSheetExampleState({required this.status, this.errors = const {}});

  factory BottomSheetExampleState.initial() => const BottomSheetExampleState(
    status: BottomSheetExampleStatus.initialize,
  );

  BottomSheetExampleState copyWith({
    BottomSheetExampleStatus? status,
    Map<BottomSheetExampleErrorType, AppFailure>? errors,
  }) {
    return BottomSheetExampleState(
      status: status ?? this.status,
      errors: errors ?? this.errors,
    );
  }

  @override
  List<Object?> get props => [status, errors];
}
