import 'package:flutter/widgets.dart';

import 'module_di.dart';

class ModuleRoute implements ModuleBase {
  final Map<String, WidgetBuilder> Function() _run;

  ModuleRoute(this._run);

  Map<String, WidgetBuilder> routes() => _run();
}

class RouteGroup {
  final Map<String, WidgetBuilder> _routes = {};

  Map<String, WidgetBuilder> get routes => _routes;

  RouteGroup();

  void register(ModuleRoute module) {
    _routes.addAll(module.routes());
  }
}

final moduleRoutes = RouteGroup();
