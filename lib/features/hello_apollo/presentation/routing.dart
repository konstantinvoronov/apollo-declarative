import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'controllers/hello_apollo_controller.dart';
import 'screens/hello_apollo_screen.dart';

List<RouteBase> buildHelloApolloRoutes(GetIt di) {
  return [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          HelloApolloScreen(controller: di<HelloApolloController>()),
    ),
  ];
}
