
import 'package:flutter/services.dart';
import '../../../../../app/di.dart';
import '../../../../../app/routing/app_router.dart';
import '../models/layout/app_sizes.dart';
import 'app_element.dart';
import 'package:flutter/material.dart';

import '../../../../../core/presentation/models/assets.gen.dart';
import '../../../../../core/domain/services/i_app_haptic_service.dart';
import '../models/themes/app_theme.dart';
import 'buttons/app_icon_button.dart';

/// UIAppBar основной AppBar приложения
///
/// Scaffold(
//       backgroundColor: AppTheme.theme.colors.bgPrimary,
//       appBar: const UIAppBar(
//         isAddWalletVisible: true,
//       ) ...

class AppScreenBar extends StatelessWidget implements PreferredSizeWidget, AppElement{
  final Widget? title;
  final AppIconButton? leadingButton;
  final bool isBackButtonVisible;
  final Color? backgroundColor;
  final Color? backButtonBgColor;
  final Widget? flexibleSpace;
  final double? height;
  final Color? backButtonIconColor;
  final Color? backButtonIconActiveColor;
  final List<Widget>? actions;

  const AppScreenBar({this.leadingButton,this.title, this.height, this.flexibleSpace, required this.isBackButtonVisible,this.backgroundColor,this.backButtonBgColor,this.backButtonIconActiveColor,this.backButtonIconColor,this.actions});


  factory AppScreenBar.grayRounded(){
    return AppScreenBar(isBackButtonVisible: true,
      backgroundColor: AppTheme.theme.colors.bgSecondary,
    );
  }
  @override
  Widget build(BuildContext context) {
    final appSizes = AppSizes.of(context);

    return AppBar(
      title: title,
      toolbarHeight: height ?? AppSizes.appbarHeight,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      flexibleSpace: flexibleSpace,
      leading: Padding(
          padding: EdgeInsets.only(left: appSizes.ssw(appSizes.horizontalPaddingDefault)),
          child: Center(child: leadingButton)),
      leadingWidth: AppSizes.sh(48) + appSizes.ssw(appSizes.horizontalPaddingDefault),
      automaticallyImplyLeading: false,
      actions: [Padding(
        padding: EdgeInsets.only(right: appSizes.ssw(appSizes.horizontalPaddingDefault)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: actions ?? [],),
      )
      ],
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black54,
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
    );
  }

  factory AppScreenBar.RoundedSemiTransparent({Widget? title, List<Widget>? actions,AppIconButton? leadingButton}){
    final double statusBarHeight = AppSizes.paddingTop;
    final double totalHeight = statusBarHeight + AppSizes.sw(30) + AppSizes.appbarHeight;

    return AppScreenBar(isBackButtonVisible: true,
      title: title,
      height: AppSizes.appbarHeight+AppSizes.sw(7),
      leadingButton: leadingButton ??  AppIconButton.Green(svgGenImage: Assets.images.back,
        onTap: () {
          di<IAppHapticService>().clickResponse();
          if (di<AppRouter>().router.canPop()) {
            di<AppRouter>().router.pop(true);
          } else {
            di<AppRouter>().router.go('/');
          }
        }),
      backgroundColor: AppTheme.theme.colors.bgThird,
      flexibleSpace: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppSizes.sh(30)),
          bottomRight: Radius.circular(AppSizes.sh(30)),
        ),
        child: Container(
          height: totalHeight,
          color: AppTheme.theme.colors.bgThird,
        ),
      ),
      actions: actions,
    );
  }

  factory AppScreenBar.SemiTransparent({Widget? title, List<Widget>? actions,AppIconButton? leadingButton}){
    return AppScreenBar(isBackButtonVisible: true,
      title: title,
      leadingButton: leadingButton ??  AppIconButton.Green(svgGenImage: Assets.images.back,
          onTap: () {
            di<IAppHapticService>().clickResponse();
            if (di<AppRouter>().router.canPop()) {
              di<AppRouter>().router.pop(true);
            } else {
              di<AppRouter>().router.go('/');
            }
          }),
      backgroundColor: AppTheme.theme.colors.bgSecondary,
      backButtonBgColor: Color(0x990A0B13),
      backButtonIconActiveColor: AppTheme.theme.colors.iconPrimaryActive,
      backButtonIconColor: AppTheme.theme.colors.iconSecondary,
      actions: actions,
    );
  }


  @override
  Size get preferredSize => Size.fromHeight(height??AppSizes.appbarHeight);

  factory AppScreenBar.noReturn({Widget? title}) {
    return AppScreenBar(title: title,isBackButtonVisible:false);
  }

}
