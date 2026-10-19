import 'package:flutter/material.dart';

import '../shared/assets/assets.gen.dart';
import 'app.dart';

class AppBootstrap extends StatefulWidget {
  final Widget child;

  const AppBootstrap({super.key,required this.child});
  @override
  State<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends State<AppBootstrap> {
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  Future<void> _initAsync() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await precacheImage(Assets.images.launchFootballPlayer.provider(), context);
      if (mounted) setState(() => _ready = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    // Once ready, show your real app
    return widget.child;
  }
}
