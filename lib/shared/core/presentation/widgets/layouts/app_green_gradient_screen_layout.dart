// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:footunion/libs/app_uikit/app/consts/app_sizes.dart';
// import 'package:footunion/libs/app_uikit/shared/presentation/app_theme.dart';
// import 'package:footunion/libs/app_uikit/shared/widgets/layouts/app_screen_layout.dart';
//
// import '../../../libs/app_uikit/shared/widgets/app_bar.dart';
//
// class AppGreenGradientScreen extends AppScreenLayout {
//   @override
//   final Widget? child;
//   final Widget? title;
//   final Color? backgroundColor;
//   final AppScreenBar? appBar;
//   final bool? extendBodyBehindAppBar;
//
//   const AppGreenGradientScreen({this.appBar,super.key, this.extendBodyBehindAppBar, this.child, super.children, super.padding, this.backgroundColor, this.title})
//       : assert(children != null || child != null, 'You must provide either child or children');
//
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = AppTheme.of(context);
//
//     return Scaffold(
//         extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
//         backgroundColor: theme.colors.bgPrimary,
//         appBar: appBar,
//         body: WrapInBackGround(SafeArea(child: Padding(
//             padding: padding?.of(context) ?? EdgeInsets.zero,
//             child: child ??
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: children ?? [],
//                 )),
//         ), context));
//   }
//
//   Widget WrapInBackGround(Widget child, BuildContext context) {
//     final appSizes = AppSizes.of(context);
//
//     return Stack(
//       children: [
//         Align(
//           alignment: Alignment.topCenter,
//           child: IgnorePointer(
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.66,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     const Color(0xCC30D9BA),
//                     const Color(0x00197363),
//                   ],
//                   stops: const [0.0, 1.0],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         child,
//       ],
//     );
//   }
// }
