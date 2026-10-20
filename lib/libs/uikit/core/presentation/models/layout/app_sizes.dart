import 'app_text_scaler.dart';
import '../../widgets/app_uiscale.dart';
import 'package:flutter/material.dart';

// final sizes = AppUiScaleWidget.of(context);
// в константах и энамах используем константы
// там где есть контент по возможности испольозвать AppSizes of
// где нет контекста можно использовать статик
/// нужно объяснить присутствие в коде фарша (нарушаем SOT) из статики и final'
/// это из-за контектса. в некоторых местах мы хотим вот такое использование
/// нам нужно чтобы в каждом build стоял final appSizes = AppSizes.of(context);
/// чтобы происходил перевызов build при обновлении контекста
/// но таскать его за собой умышленно нет желания по этому проще использовать статику
/// в мире где нет контекста этого и делать не нужно. но не в этом мире
class AppSizes {
  AppSizes();


  static AppSizes of(BuildContext context) => AppUiScaleWidget.of(context);

  static const double defaultGap = 4.0;

  static const double gap1x = 4.0;
  static const double gap2x = 8.0;
  static const double gap3x = 12.0;
  static const double gap4x = 16.0;
  static const double gap5x = 20.0;
  static const double gap6x = 24.0;
  static const double gap7x = 28.0;
  static const double gap8x = 32.0;

  // ---- scaling helpers (assigned in init) ----
  static late double Function(double) sp; // uniform
  static late double Function(double) sw; // width-based
  static late double Function(double) sh; // height-based

  late final double Function(double) ssp; // uniform
  late final double Function(double) ssw; // width-based
  late final double Function(double) ssh; // height-based

  /// use effectiveScreenHeight,effectiveScreenWidth for calculation instead of MediaQuery
  late final double effectiveScreenHeight;
  late final double effectiveScreenWidth;
  static double paddingTop = 0.0;



  // ---- cached values gap1w - width / gap1h - height
  static late double gap1w, gap2w, gap3w,gap4w,gap5w,gap6w;
  static late double gap1h, gap2h, gap3h,gap4h,gap5h,gap6h;

  // static
  // vgap1x - vertical / hgap1x - horizontal
  static late Widget vgap1x,vgap2x,vgap3x,vgap4x,vgap5x,vgap6x,vgap7x,vgap8x,vgap9x,vgap10x;
  static late Widget hgap1x,hgap2x,hgap3x,hgap4x,hgap5x,hgap6x,hgap7x,hgap8x,hgap9x,hgap10x;

  // finals
  late Widget vgap1,vgap2,vgap3,vgap4,vgap5,vgap6,vgap7,vgap8,vgap9,vgap10;
  late Widget hgap1,hgap2,hgap3,hgap4,hgap5,hgap6,hgap7,hgap8,hgap9,hgap10;

  static late double btnHeightSm, btnHeightMd, btnHeightLg;

  void init({
    required double sx,
    required double sy,
    required double s, required double effectiveScreenWidth, required double effectiveScreenHeight,required double paddingTop}) {

    this.effectiveScreenWidth = effectiveScreenWidth;
    this.effectiveScreenHeight = effectiveScreenHeight;
    AppSizes.paddingTop = paddingTop;
    // helpers
    sp = (v) => v * s;
    sw = (v) => v * sx;
    sh = (v) => v * sy;

    ssp = (v) => v * s;
    ssw = (v) => v * sx;
    ssh = (v) => v * sy;


    gap1w = sw(defaultGap*1);
    gap2w = sw(defaultGap*2);
    gap3w = sw(defaultGap*3);
    gap4w = sw(defaultGap*4);
    gap5w = sw(defaultGap*5);
    gap6w = sw(defaultGap*6);

    gap1h = sh(defaultGap*1);
    gap2h = sh(defaultGap*2);
    gap3h = sh(defaultGap*3);
    gap4h = sh(defaultGap*4);
    gap5h = sh(defaultGap*5);
    gap6h = sh(defaultGap*6);


    hgap1 = hgap1x = SizedBox(width: sw(defaultGap*1));
    hgap2 = hgap2x = SizedBox(width: sw(defaultGap*2));
    hgap3 = hgap3x = SizedBox(width: sw(defaultGap*3));
    hgap4 = hgap4x = SizedBox(width: sw(defaultGap*4));
    hgap5 = hgap5x = SizedBox(width: sw(defaultGap*5));
    hgap6 = hgap6x = SizedBox(width: sw(defaultGap*6));
    hgap7 = hgap7x = SizedBox(width: sw(defaultGap*7));
    hgap8 = hgap8x = SizedBox(width: sw(defaultGap*8));
    hgap9 = hgap9x = SizedBox(width: sw(defaultGap*9));
    hgap10 = hgap10x = SizedBox(width: sw(defaultGap*10));

    vgap1 = vgap1x = SizedBox(height: sh(defaultGap*1));
    vgap2 = vgap2x = SizedBox(height: sh(defaultGap*2));
    vgap3 = vgap3x = SizedBox(height: sh(defaultGap*3));
    vgap4 = vgap4x = SizedBox(height: sh(defaultGap*4));
    vgap5 = vgap5x = SizedBox(height: sh(defaultGap*5));
    vgap6 = vgap6x = SizedBox(height: sh(defaultGap*6));
    vgap7 = vgap7x = SizedBox(height: sh(defaultGap*7));
    vgap8 = vgap8x = SizedBox(height: sh(defaultGap*8));
    vgap9 = vgap9x = SizedBox(height: sh(defaultGap*9));
    vgap10 = vgap10x =  SizedBox(height: sh(defaultGap*10));

    btnHeightSm = sh(45);
    btnHeightMd = sh(50);
    btnHeightLg = sh(60);

    horizontalPaddingDefault = sw(15);
    horizontalPaddingLarge = sw(48);
    horizontalPaddingDialog = sw(15);

    borderRadiusDefault = sp(16);
    borderRadiusLarge = sp(32.0);


    // ---- borders ----
    borderWidth        = sp(1);
    borderWidth2       = sp(2);
    buttonBorderWidth  = sp(1.5);
    borderWidthThick   = sp(2);

    // ---- list separators ----
    listItemsHorizontalSeparator = sw(10);
    listItemsVerticalSeparator   = sh(15);

    // ---- app bar / bars ----
    appbarHeight = sh(70); //kToolbarHeight; // leave as Flutter constant

    // ---- dialogs / overlays ----
    modalDialogTopInset      = sh(20);
    bottomMenuInset          = sh(106);
    bottomButtonInset        = sh(70);

    // ---- round buttons / icons ----
    roundButtonIconHeight  = sp(15);
    roundButtonIconHeightL = sp(30);
    circleIconButtonSize   = sp(25);
    circleButtonSmallHeight= sh(40);
    circleButtonHeight     = sh(50);

    // ---- misc sizes ----
    customKeyboardGap = sp(20);

    appBtnPaddingVertical   = sp(7);
    appBtnPaddingHorizontal = sp(18);
    appBtnIconSizeSmall     = sp(30);
    appBtnIconSize          = sp(56);
    appBtnIconRadius        = sp(28);
    appBtnIconPadding       = sp(10.5);

    appTextScaler = AppTextScaler(s: s);
  }

  late final AppTextScaler appTextScaler;

// paddings
  late double horizontalPaddingDefault, horizontalPaddingLarge, horizontalPaddingMedium, horizontalPaddingDialog, bottomPaddingDefault;

  // radii
  static late double appbarHeight,borderRadiusMicro, borderRadiusSmall, borderRadiusDefault, borderRadius13, borderRadiusMedium, borderRadiusLarge, borderRadiusExtraLarge, borderRadiusXXL;

  // borders
  static late double borderWidth, borderWidth2, buttonBorderWidth, borderWidthThick, bottomButtonInset;

  // list
  static late double listItemsHorizontalSeparator, listItemsVerticalSeparator;

  // dialogs
  static late double modalDialogTopInset, bottomMenuInset;

  // icons/buttons
  static late double roundButtonIconHeight, roundButtonIconHeightL;
  static late double circleIconButtonSize, circleButtonSmallHeight, circleButtonHeight;
  static late double customKeyboardGap;

  static late double appBtnPaddingVertical, appBtnPaddingHorizontal, appBtnIconSizeSmall, appBtnIconSize, appBtnIconRadius, appBtnIconPadding;
}
