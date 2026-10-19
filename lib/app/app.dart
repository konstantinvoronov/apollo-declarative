import 'app_bootstrap.dart';
import 'routing/app_router.dart';
import 'config/app_conf.dart';
import 'package:ai_declarative_foldering_architecture/libs/app_uikit/shared/widgets/app_uiscale.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../libs/app_uikit/shared/presentation/app_theme.dart';
import 'di.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        theme: AppTheme.dark, // TODO return back later AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        routerConfig: di<AppRouter>().router,
        builder: (ctx, child) => AppBootstrap(child:AppUiScaleWidget(
          context: ctx,
          widthLimitRatio: 2/3,
          designWidth: AppConf.designW,
          designHeight: AppConf.designH,
          child: child ?? const SizedBox.shrink(),
        ))
    );
  }
}
