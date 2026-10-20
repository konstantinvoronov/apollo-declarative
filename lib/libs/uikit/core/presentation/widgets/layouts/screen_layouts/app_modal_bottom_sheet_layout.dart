import 'package:flutter/material.dart';

import '../../../models/layout/app_sizes.dart';
import '../../../models/themes/app_theme.dart';
import '../app_screen_layout.dart';

///
/// BetterAppModalSheet - измененная версия AppModelSheet с увеличенной совместимостью. поддерживает и constrained и unconstrained layout.
///
/// имеет параметр shrinkWrap но по умолчанию имеет констрейнс.
/// таким образом совместима со всеми верстками на всякий случай имеет параметр backSupport чтобы убирать заголовок там где он не нужен (старые модалки)
/// не работает скрытие модалки по нажатию на пустой фон
///
class AppModalBottomSheetLayout extends AppScreenLayout{
  @override
  Widget get child => super.child!;
  final bool shrinkWrap;
  final double? height;
  final double? childTopPadding;
  final double? childBottomPadding;
  final String title;
  final Color? backgroundColor;
  final bool backSupport;
  final bool fullScreen;

  static const bottomSheetInset = 16;

  /// AppModalBottomDialog
  const AppModalBottomSheetLayout({
    super.key,
    required Widget child,
    this.childBottomPadding,

    /// shrinkWrap - делает окно минимального размера или размера высоты если задана высота
    required this.shrinkWrap,
    this.childTopPadding,
    this.title = '',
    this.backSupport = false,

    // убирает заголовок и окантовку делая модалку готовой для полностью кастомного шита
    this.fullScreen = false,
    this.backgroundColor,

    /// если !shrinkWrap и высота то будет заданная высота иначе будет expanded
    this.height,
  }) : super(child: child);

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final effectiveTopPadding =  (topPadding==0.0) ? AppSizes.gap8x : topPadding;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            }, // мне нужно чтобы когда !shrinkWrap размер либо задавался четко, лебо был
            child: (fullScreen)
                ? child
                : Align(
    alignment: Alignment.bottomCenter,
    child: Container(
                height: (height == null || shrinkWrap)
                    ? null
                    : (!shrinkWrap || height != null)
                        ? height
                        : MediaQuery.of(context).size.height,
                child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: (!fullScreen) ? EdgeInsets.only(top: effectiveTopPadding) : EdgeInsets.zero,
                          child: AppSheet(
                            title: title,
                            backSupport: backSupport,
                            backgroundColor: backgroundColor,
                            topInset: childBottomPadding,
                            shrinkWrap: shrinkWrap,
                            child: child,
                          ),
                        ))))));
  }
}

class AppSheet extends StatelessWidget {
  final Color? backgroundColor;
  final String? title;

  /// backSupport - вставляет подпорку которую используют старые окна
  final bool backSupport;

  /// topInset - отступ от верха страницы
  final double? topInset;

  /// если shrinkWrap = false, элемент пытается занять весь constraints
  final bool shrinkWrap;

  final Widget child;

  const AppSheet(
      {Key? key,
      this.backgroundColor,
      this.title,
      this.backSupport = false,
      this.topInset = 0,
      required this.child,
      this.shrinkWrap = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Stack(alignment: AlignmentDirectional.topCenter, children: [
          ClipPath(
              clipper: DialogShape(),
              child: Container(
                  color: backgroundColor ?? AppTheme.theme.colors.bgSecondary,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                      right: 5,
                      bottom: MediaQuery.of(context).viewPadding.bottom,
                      left: 5,
                    ),
                    child: Column(
                        mainAxisSize:
                            (shrinkWrap) ? MainAxisSize.min : MainAxisSize.max,
                        children: [
                          // if (title != null)
                          //   throw('not supperted feature')
                          // BottomSheetAppBar(
                          //   text: title,
                          // ),
                          // if (!backSupport) ...[SizedBox(height: topInset)],
                          (shrinkWrap)
                              ? Flexible(child: child)
                              : Expanded(child: child),
                        ]),
                  ))),
          _sheetLine(),
          Positioned(
            top: 0,
            child: Container(
              height: 4,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: uiTheme.colors.bgSecondary,
              ),
            ),
          ),
        ]));
  }

  static Widget _sheetLine() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: AppTheme.theme.colors.bgPrimary,
        ),
      );
  }

}





class DialogShape extends CustomClipper<Path> {
  DialogShape();

  @override
  Path getClip(Size size) {
    final path = Path();

    // Параметры
    const double notchWidth = 82; // Ширина выемки
    const double sCurveWidth = 13; // Ширина изгиба
    const double notchHeight = 10; // Высота выемки
    const double sCurveCenterHeight = 6; // Высота центра выемки
    const double sCurveCenterWidth = 6; // Ширина центра выемки
    const double cornerRadius = 30; // Радиус скругления углов
    const double notchRadius = 10; // Радиус углов внутри выемки
    const double horizontalPadding = 5;

    // Левый верхний угол
    path.moveTo(horizontalPadding, cornerRadius);
    path.quadraticBezierTo(
      horizontalPadding,
      0,
      cornerRadius + horizontalPadding,
      0,
    );

    // До начала выемки
    path.lineTo((size.width - notchWidth) / 2, 0);

    // // Левый скруглённый угол выемки
    // path.arcToPoint(
    //   Offset((size.width - notchWidth) / 2 + sCurveCenterWidth, sCurveCenterHeight),
    //   radius: const Radius.circular(notchRadius),
    // );
    //
    // path.arcToPoint(
    //   Offset((size.width - notchWidth) / 2 + sCurveWidth, notchHeight),
    //   radius: const Radius.circular(15),
    //   clockwise: false,
    // );

    // // Нижняя линия выемки
    // path.lineTo((size.width + notchWidth) / 2 - sCurveWidth, notchHeight);
    //
    // // Правый скруглённый угол выемки
    // path.arcToPoint(
    //   Offset((size.width + notchWidth) / 2 - sCurveCenterWidth, sCurveCenterHeight),
    //   radius: const Radius.circular(15),
    //   clockwise: false,
    // );
    //
    // path.arcToPoint(
    //   Offset((size.width + notchWidth) / 2, 0),
    //   radius: const Radius.circular(notchRadius),
    // );

    // До правого верхнего угла
    path.lineTo(size.width - cornerRadius, 0);
    path.quadraticBezierTo(
      size.width - horizontalPadding,
      0,
      size.width - horizontalPadding,
      cornerRadius,
    );

    // Правый нижний угол
    path.lineTo(size.width - horizontalPadding, size.height);

    // Левый нижний угол
    path.lineTo(horizontalPadding, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}



