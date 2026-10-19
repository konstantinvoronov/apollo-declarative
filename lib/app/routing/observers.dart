
import 'package:flutter/material.dart';

class GoRouterObserver extends NavigatorObserver {
  GoRouterObserver();

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute){
    debugPrint('didPop: ${route.settings.name} (${route.runtimeType})');
  }


  @override
  void didRemove(Route route, Route? previousRoute) {
    debugPrint('didRemove: ${route.settings.name} (${route.runtimeType})');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    debugPrint('didReplace: ${oldRoute?.settings.name} -> ${newRoute?.settings.name}');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if(route.settings.name!=null){
      print('PUSHED SCREEN: ${route.settings.name}'); //name comes back null
    }
  }
}
