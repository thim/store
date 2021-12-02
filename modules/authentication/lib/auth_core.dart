import 'package:authentication/src/domain/refresh_token_usecase.dart';
import 'package:core/core.dart';

import 'src/data/refresh_token.dart';

List<ModuleBase> authCoreModules() => [
      ModuleBase.di(() async {
        registerDependency<RefreshTokenUseCase>(() => RefreshToken());
      }),
      ModuleBase.boot((map) async {
        final refreshToken = inject<RefreshTokenUseCase>();
        final refreshed = await refreshToken();
        if (!refreshed) {
          await moduleLifecycle.onLogout();
        }
        map[refreshedKey] = refreshed;
      })
    ];

const String refreshedKey = "refreshed";