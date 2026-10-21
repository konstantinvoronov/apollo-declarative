import 'package:app_failure/app_failure.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'bottom_sheet_example_state.dart';

class BottomSheetExampleCubit extends Cubit<BottomSheetExampleState> {
  BottomSheetExampleCubit() : super(BottomSheetExampleState.initial()) {
    _initialize();
  }

  Future<void> _initialize() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    if (isClosed) return;
    emit(state.copyWith(status: BottomSheetExampleStatus.ready));
  }

  void clearUnhandledError(BottomSheetExampleErrorType? err) {
    emit(
      state.copyWith(
        errors: {...state.errors}
          ..remove(err ?? BottomSheetExampleErrorType.unhandledError),
      ),
    );
  }
}
