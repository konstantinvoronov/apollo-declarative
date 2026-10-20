import 'package:app_failure/app_failure.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/domain/services/i_app_build_info_service.dart';

part 'hello_apollo_state.dart';

class HelloApolloCubit extends Cubit<HelloApolloState> {
  HelloApolloCubit(IAppBuildInfoService buildInfo)
    : super(
        HelloApolloState.initial(
          version: buildInfo.version,
          buildNumber: buildInfo.buildNumber,
        ),
      );

  void clearUnhandledError(HelloApolloErrorType? err) {
    emit(
      state.copyWith(
        errors: {...state.errors}
          ..remove(err ?? HelloApolloErrorType.unhandledError),
      ),
    );
  }
}
