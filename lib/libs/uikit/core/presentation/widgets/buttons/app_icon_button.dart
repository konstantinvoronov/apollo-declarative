import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/themes/color_extensions.dart';
import '../text/styles_extension.dart';
import '../../models/themes/app_theme.dart';
import '../../models/layout/app_icon_button_sizes.dart';
import '../../../../../../core/presentation/models/assets.gen.dart';

import '../../../../../../app/di.dart';
import '../../../../../../app/routing/app_router.dart';
import '../../models/layout/app_sizes.dart';
import 'button_animation.dart';

class AppIconButton extends StatelessWidget {
  final VoidCallback? onTap;
  final SvgGenImage icon;
  final Color? iconColor;
  final Color? iconActiveColor;
  final Color? bgColor;
  final AppIconButtonSizes appIconButtonSizes;
  final String? text;
  final Color? textColor;

  const AppIconButton({
    this.onTap,
    required this.icon,
    this.iconColor,
    this.iconActiveColor,
    this.bgColor,
    required this.appIconButtonSizes,
    this.text,
    this.textColor,
  });

  factory AppIconButton.back({
    VoidCallback? onTap,
    Color? bgColor,
    Color? iconColor,
    Color? iconActiveColor,
  }) {
    return AppIconButton(
      onTap: onTap == null ? (){
        if (di<AppRouter>().router.canPop()) {
          di<AppRouter>().router.pop(true);
        } else {
          di<AppRouter>().router.go('/');
        }
      }: () {
        onTap?.call();
      },
      icon: Assets.images.back,
      iconColor: iconColor,
      iconActiveColor: iconActiveColor,
      appIconButtonSizes: AppIconButtonSizes.small,
      bgColor: bgColor,
    );
  }

  factory AppIconButton.AppBarButton({
    VoidCallback? onTap,
    Color? bgColor,
    Color? iconColor,
    required SvgGenImage svgGenImage,
    Color? iconActiveColor,
  }) {
    return AppIconButton(
      onTap: onTap == null ? (){
        if (di<AppRouter>().router.canPop()) {
          di<AppRouter>().router.pop(true);
        } else {
          di<AppRouter>().router.go('/');
        }
      }: () {
        onTap?.call();
      },
      icon: svgGenImage,
      iconColor: iconColor,
      iconActiveColor: iconActiveColor,
      appIconButtonSizes: AppIconButtonSizes.small,
      bgColor: bgColor,
    );
  }


  factory AppIconButton.Green({
    VoidCallback? onTap,
    Color? bgColor,
    Color? iconColor,
    required SvgGenImage svgGenImage,
    AppIconButtonSizes? size,
    Color? iconActiveColor,
  }) {
    return AppIconButton(
      onTap: () => onTap?.call(),
      icon: svgGenImage,
      iconActiveColor: AppTheme.theme.colors.iconPrimaryActive,
      iconColor: AppTheme.theme.colors.iconSecondary,
      appIconButtonSizes: size ?? AppIconButtonSizes.small,
      bgColor: AppTheme.theme.colors.buttonSecondaryDefault,
    );
  }

  factory AppIconButton.AppBarButtonSemiTransparent({
    VoidCallback? onTap,
    Color? bgColor,
    Color? iconColor,
    required SvgGenImage svgGenImage,
    Color? iconActiveColor,
  }) {
    return AppIconButton(
      onTap: () => onTap?.call(),
      icon: svgGenImage,
      iconActiveColor: AppTheme.theme.colors.iconPrimaryActive,
      iconColor: AppTheme.theme.colors.iconSecondary,
      appIconButtonSizes: AppIconButtonSizes.small,
      bgColor: Color(0x990A0B13),
    );
  }



  @override
  Widget build(BuildContext context) {
    final uiTheme = AppTheme.of(context);
    final appSizes = AppSizes.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ButtonAnimation(
          onTap: onTap,
          defaultColor: iconColor,
          activeColor: iconActiveColor,
          child: (color) => Container(
            height: appSizes.ssw(appIconButtonSizes.buttonRadius),
            width: appSizes.ssw(appIconButtonSizes.buttonRadius) ,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor ?? uiTheme.colors.bgSecondary,
            ),
            child: Center(
              child: icon.svg(
                colorFilter: color.toFilter,
                height: appSizes.ssw(appIconButtonSizes.iconSize),
              ),
            ),
          ),
        ),
        if (text != null)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: (text??'').p2(color: textColor,),
            ),
      ],
    );
  }
}
