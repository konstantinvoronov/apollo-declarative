import 'package:app_failure/app_failure.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/apollo_welcome.dart';
import '../../../../libs/uikit/core/presentation/mixins/navigation_mixins.dart';
import '../../../../libs/uikit/core/presentation/widgets/layouts/app_flexible_layouts.dart';
import '../../../../libs/uikit/core/presentation/widgets/text/styles_extension.dart';
import '../../../../shared/core/presentation/mixins/app_handle_failure_mixin.dart';
import '../../../../shared/core/presentation/widgets/layouts/app_screens_layouts_extension.dart';
import '../controllers/hello_apollo_cubit.dart';

class HelloApolloScreen extends StatelessWidget
    with EventOnSuccess<bool>, AppHandleFailure {
  final HelloApolloCubit Function() createCubit;
  final AppOnSuccess<bool>? onSuccess;

  const HelloApolloScreen({
    super.key,
    required this.createCubit,
    this.onSuccess,
  });

  @override
  AppOnSuccess<bool>? get getOnSuccess => onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HelloApolloCubit>(
      create: (_) => createCubit(),
      child: Builder(
        builder: (ctx) => BlocConsumer<HelloApolloCubit, HelloApolloState>(
          builder: mainBuilder,
          listener: mainListener,
        ),
      ),
    );
  }

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

  Widget mainBuilder(BuildContext context, HelloApolloState state) {
    return AppScreenLayouts.appBasicScreen(
      child: AppFlexibleLayouts.FixedVisibleBottomLayoutWithForcedToFillContent(
        padding: AppLayoutPaddings.zero,
        paddingBottom: AppLayoutPaddings.zero,
        bottomChildren: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: 'hello_apollo.greeting'.tr().p4(
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
        child: ApolloWelcome(
          version: state.version,
          buildNumber: state.buildNumber,
        ),
      ),
    );
  }
}
