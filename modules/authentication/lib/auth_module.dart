import 'package:core/core_flutter.dart';

import 'auth_core.dart';
import 'src/presentation/login_page.dart';

List<ModuleBase> authModule() => [
      ...authCoreModules(),
      ModuleRoute(() => {LoginPage.route: (context) => const LoginPage()}),
    ];
