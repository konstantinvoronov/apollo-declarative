import 'package:flutter/material.dart';

import '../controllers/hello_apollo_controller.dart';

class HelloApolloScreen extends StatelessWidget {
  final HelloApolloController controller;

  const HelloApolloScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(controller.greeting)));
  }
}
