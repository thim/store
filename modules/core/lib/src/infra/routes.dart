import 'package:flutter/widgets.dart';

abstract class ModuleRoute {
  Map<String, WidgetBuilder> routes();
}

final moduleRoutes = RouteGroup();

class RouteGroup {
  final Map<String, WidgetBuilder> _routes = {};

  Map<String, WidgetBuilder> get routes => _routes;

  RouteGroup();

  call(List<ModuleRoute> modules) {
    for (ModuleRoute module in modules) {
      _routes.addAll(module.routes());
    }
  }
}
