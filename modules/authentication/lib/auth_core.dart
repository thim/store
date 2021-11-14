import 'package:authentication/src/domain/refresh_token_usecase.dart';
import 'package:core/core.dart';
import 'package:core/core_flutter.dart';

import 'src/data/refresh_token.dart';

class AuthDI implements ModuleDI, ModuleBoot {
  @override
  Future<void> registerInject(AppInject injector) async {
    injector.registerDependency<RefreshTokenUseCase>(() => RefreshToken());
  }

  @override
  Future<void> boot(Map map) async {
    final refreshToken = inject<RefreshTokenUseCase>();
    final refreshed = await refreshToken();
    if (!refreshed) {
      await flutterModule.moduleLifecycle.onLogout();
    }
    map["refreshed"] = refreshed;
  }
}
