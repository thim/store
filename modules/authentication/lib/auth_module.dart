import 'package:core/core_flutter.dart';
import 'package:flutter/widgets.dart';

import 'auth_core.dart';
import 'src/presentation/login_page.dart';

class AuthModule with AuthDI implements ModuleRoute {
  @override
  Map<String, WidgetBuilder> routes() => {LoginPage.route: (context) => const LoginPage()};
}
