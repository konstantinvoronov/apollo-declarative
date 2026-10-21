import 'package:app_failure/app_failure.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/domain/services/i_app_build_info_service.dart';
import '../../../../core/domain/services/i_app_log_share_service.dart';

part 'about_apollo_state.dart';

class AboutApolloCubit extends Cubit<AboutApolloState> {
  final IAppLogShareService _logShareService;

  AboutApolloCubit(IAppBuildInfoService buildInfo, this._logShareService)
    : super(
        AboutApolloState.initial(
          version: buildInfo.version,
          buildNumber: buildInfo.buildNumber,
        ),
      );

  Future<void> onVersionTap() async {
    if (state.logShareStatus == AboutApolloLogShareStatus.sharing) return;
    final tapCount = state.versionTapCount + 1;
    if (tapCount < 10) {
      emit(state.copyWith(versionTapCount: tapCount));
      return;
    }
    emit(state.copyWith(
      versionTapCount: 0,
      logShareStatus: AboutApolloLogShareStatus.sharing,
    ));
    try {
      (await _logShareService.shareLog()).fold(
        (_) {},
        (failure) => throw failure,
      );
      if (isClosed) return;
      emit(state.copyWith(logShareStatus: AboutApolloLogShareStatus.idle));
    } catch (error, stackTrace) {
      if (isClosed) return;
      emit(state.copyWith(
        logShareStatus: AboutApolloLogShareStatus.idle,
        errors: {
          ...state.errors,
          AboutApolloErrorType.unhandledError: AppFailure.controllerFailure(
            logMessage: 'About Apollo version-tap log sharing failed',
            cause: error,
            stackTrace: stackTrace,
          ),
        },
      ));
    }
  }

  void clearUnhandledError(AboutApolloErrorType? err) {
    emit(
      state.copyWith(
        errors: {...state.errors}
          ..remove(err ?? AboutApolloErrorType.unhandledError),
      ),
    );
  }

  void recordSheetResult(bool? result) {
    emit(
      state.copyWith(
        sheetResult: result == true
            ? AboutApolloSheetResult.confirmed
            : AboutApolloSheetResult.cancelled,
      ),
    );
  }
}
