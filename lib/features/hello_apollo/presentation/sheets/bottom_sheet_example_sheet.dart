import 'package:app_failure/app_failure.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../libs/uikit/core/presentation/mixins/navigation_mixins.dart';
import '../../../../libs/uikit/core/presentation/widgets/layouts/app_flexible_layouts.dart';
import '../../../../libs/uikit/core/presentation/widgets/text/styles_extension.dart';
import '../../../../shared/core/presentation/mixins/app_handle_failure_mixin.dart';
import '../../../../shared/core/presentation/widgets/layouts/app_screens_layouts_extension.dart';
import '../controllers/bottom_sheet_example_cubit.dart';
import '../models/bottom_sheet_example_params.dart';

class BottomSheetExampleSheet extends StatelessWidget
    with EventOnSuccess<bool>, EventOnSkip<bool>, AppHandleFailure {
  final BottomSheetExampleCubit Function() createCubit;
  final BottomSheetExampleParams params;

  const BottomSheetExampleSheet({
    super.key,
    required this.createCubit,
    this.params = const BottomSheetExampleParams(),
  });

  @override
  AppOnSuccess<bool>? get getOnSuccess => params.onSuccess;

  @override
  AppOnSkip<bool>? get getOnSkip => null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomSheetExampleCubit>(
      create: (_) => createCubit(),
      child: Builder(
        builder: (ctx) =>
            BlocConsumer<BottomSheetExampleCubit, BottomSheetExampleState>(
              builder: mainBuilder,
              listener: mainListener,
            ),
      ),
    );
  }

  void mainListener(BuildContext context, BottomSheetExampleState state) {
    final cubit = context.read<BottomSheetExampleCubit>();

    for (var error in state.errors.entries) {
      if (error.value is ValidationFailure) continue;
      switch (error.key) {
        case BottomSheetExampleErrorType.unhandledError:
          uiFailureHandler(
            context: context,
            failure: error.value,
            fallback: () {
              HapticFeedback.lightImpact();
            },
            clearUnhandledError: () => cubit.clearUnhandledError(error.key),
          );
      }
    }
  }

  Widget mainBuilder(BuildContext context, BottomSheetExampleState state) {
    switch (state.status) {
      case BottomSheetExampleStatus.initialize:
        return AppFlexibleLayouts.FixedVisibleBottomLayoutWithForcedToFillContent(
          padding: AppLayoutPaddings.zero,
          paddingBottom: AppLayoutPaddings.zero,
          child: const Center(child: CircularProgressIndicator()),
        );
      case BottomSheetExampleStatus.ready:
        return AppScreenLayouts.appBasicScreen(
          child:
              AppFlexibleLayouts.FixedVisibleBottomLayoutWithScrollableExpandedContent(
                controller: PrimaryScrollController.of(context),
                bottomChildren: [
                  SafeArea(
                    top: false,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () async => await callSkipPop(),
                            child: 'hello_apollo.sheets.cancel'.tr().p4(),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () async =>
                                await callSuccessPop(context, true),
                            child: 'hello_apollo.sheets.confirm'.tr().p4(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: 'hello_apollo.sheets.title'.tr().p4(),
                  ),
                  'hello_apollo.sheets.description'.tr().p4(),
                  for (var index = 1; index <= 20; index++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: 'hello_apollo.sheets.item'
                          .tr(namedArgs: {'number': '$index'})
                          .p4(),
                    ),
                ],
              ),
        );
    }
  }
}
