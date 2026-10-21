import 'package:flutter/material.dart';

class AppBootstrap extends StatelessWidget {
  final Widget child;

  const   AppBootstrap({super.key,required this.child});
  @override
  Widget build(BuildContext context) {
    // Once ready, show your real app
    return child;
  }
}
