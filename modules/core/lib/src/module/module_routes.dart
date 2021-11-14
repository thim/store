import 'package:flutter/widgets.dart';

abstract class ModuleRoute {
  Map<String, WidgetBuilder> routes();
}

class RouteGroup {
  final Map<String, WidgetBuilder> _routes = {};

  Map<String, WidgetBuilder> get routes => _routes;

  RouteGroup();

  void register(ModuleRoute module) {
    _routes.addAll(module.routes());
  }
}
