import 'package:core/core_flutter.dart';
import 'package:flutter/widgets.dart';

import 'app_core.dart';
import 'src/presentation/splash.dart';

class AppModule with AppDI implements ModuleRoute {
  @override
  Map<String, WidgetBuilder> routes() => {SplashPage.route: (context) => const SplashPage()};
}
