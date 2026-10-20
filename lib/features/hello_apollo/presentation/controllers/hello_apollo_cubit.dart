import 'package:app_failure/app_failure.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'hello_apollo_state.dart';

class HelloApolloCubit extends Cubit<HelloApolloState> {
  HelloApolloCubit() : super(HelloApolloState.initial());

  void clearUnhandledError(HelloApolloErrorType? err) {
    emit(
      state.copyWith(
        errors: {...state.errors}
          ..remove(err ?? HelloApolloErrorType.unhandledError),
      ),
    );
  }
}
