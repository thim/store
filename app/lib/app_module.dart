import 'package:app/app_core.dart';
import 'package:core/core_flutter.dart';

import 'src/presentation/splash.dart';

List<ModuleBase> appModule() => [
      ...appCoreModules(),
      ModuleRoute(() => {SplashPage.route: (context) => const SplashPage()}),
    ];
