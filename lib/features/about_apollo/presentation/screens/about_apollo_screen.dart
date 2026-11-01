import 'package:app_failure/app_failure.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di.dart';
import '../../../../app/routing/app_router.dart';
import '../../../../core/presentation/widgets/apollo_welcome.dart';
import '../../../../libs/uikit/core/presentation/mixins/navigation_mixins.dart';
import '../../../../libs/uikit/core/presentation/widgets/layouts/app_flexible_layouts.dart';
import '../../../../libs/uikit/core/presentation/widgets/text/styles_extension.dart';
import '../../../../shared/core/presentation/mixins/app_handle_failure_mixin.dart';
import '../../../../shared/core/presentation/widgets/layouts/app_screens_layouts_extension.dart';
import '../controllers/about_apollo_cubit.dart';
import '../models/bottom_sheet_example_params.dart';

class AboutApolloScreen extends StatelessWidget
    with EventOnSuccess<bool>, AppHandleFailure {
  final AboutApolloCubit Function() createCubit;
  final AppOnSuccess<bool>? onSuccess;

  const AboutApolloScreen({
    super.key,
    required this.createCubit,
    this.onSuccess,
  });

  @override
  AppOnSuccess<bool>? get getOnSuccess => onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AboutApolloCubit>(
      create: (_) => createCubit(),
      child: Builder(
        builder: (ctx) => BlocConsumer<AboutApolloCubit, AboutApolloState>(
          builder: mainBuilder,
          listener: mainListener,
        ),
      ),
    );
  }

  void mainListener(BuildContext context, AboutApolloState state) {
    final cubit = context.read<AboutApolloCubit>();

    for (var error in state.errors.entries) {
      // validation error processed in ui
      if (error.value is ValidationFailure) continue;
      switch (error.key) {
        case AboutApolloErrorType.unhandledError:
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

  Widget mainBuilder(BuildContext context, AboutApolloState state) {
    return AppScreenLayouts.appBasicScreen(
      child: AppFlexibleLayouts.FixedVisibleBottomLayoutWithForcedToFillContent(
        padding: AppLayoutPaddings.zero,
        paddingBottom: AppLayoutPaddings.zero,
        bottomChildren: [
          if (context.read<AboutApolloCubit>().supportsNotifications)
            Center(
              child:
                  'about_apollo.notifications.permission_${state.notificationPermission?.name ?? 'unknown'}'
                      .tr()
                      .p4(),
            ),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                if (context.read<AboutApolloCubit>().supportsNotifications) ...[
                  TextButton(
                    onPressed:
                        state.notificationStatus ==
                            AboutApolloNotificationStatus.busy
                        ? null
                        : context
                              .read<AboutApolloCubit>()
                              .requestNotificationPermission,
                    child: 'about_apollo.notifications.enable'.tr().p4(),
                  ),
                  TextButton(
                    onPressed:
                        state.notificationStatus ==
                            AboutApolloNotificationStatus.busy
                        ? null
                        : () => context
                              .read<AboutApolloCubit>()
                              .displayExampleNotification(
                                title: 'about_apollo.notifications.title'.tr(),
                                body: 'about_apollo.notifications.body'.tr(),
                              ),
                    child: 'about_apollo.notifications.display'.tr().p4(),
                  ),
                  TextButton(
                    onPressed:
                        state.notificationStatus ==
                            AboutApolloNotificationStatus.busy
                        ? null
                        : context
                              .read<AboutApolloCubit>()
                              .cancelExampleNotification,
                    child: 'about_apollo.notifications.cancel'.tr().p4(),
                  ),
                  if (context.read<AboutApolloCubit>().supportsPush)
                    TextButton(
                      onPressed:
                          state.notificationStatus ==
                              AboutApolloNotificationStatus.busy
                          ? null
                          : context.read<AboutApolloCubit>().registerForPush,
                      child: 'about_apollo.notifications.push'.tr().p4(),
                    ),
                ],
                TextButton(
                  onPressed: () =>
                      openSheet(context, '/about-apollo/legacy-sheet'),
                  child: 'about_apollo.sheets.open_legacy'.tr().p4(),
                ),
                TextButton(
                  onPressed: () =>
                      openSheet(context, '/about-apollo/alternative-sheet'),
                  child: 'about_apollo.sheets.open_alternative'.tr().p4(),
                ),
              ],
            ),
          ),
          Center(
            child: switch (state.sheetResult) {
              AboutApolloSheetResult.none =>
                'about_apollo.sheets.result_none'.tr().p4(),
              AboutApolloSheetResult.confirmed =>
                'about_apollo.sheets.result_confirmed'.tr().p4(),
              AboutApolloSheetResult.cancelled =>
                'about_apollo.sheets.result_cancelled'.tr().p4(),
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: 'about_apollo.greeting'.tr().p4(
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
        child: ApolloWelcome(
          version: state.version,
          buildNumber: state.buildNumber,
          onVersionTap: context.read<AboutApolloCubit>().onVersionTap,
        ),
      ),
    );
  }

  Future<void> openSheet(BuildContext context, String path) async {
    final result = await di<AppRouter>().router.push<bool>(
      path,
      extra: BottomSheetExampleParams(
        onSuccess: (context, value) async => value,
      ),
    );
    if (!context.mounted) return;
    context.read<AboutApolloCubit>().recordSheetResult(result);
  }
}
