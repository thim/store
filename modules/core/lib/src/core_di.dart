import 'package:http/http.dart';

import '../core.dart';
import 'infra/network.dart';
import 'infra/network_impl.dart';
import 'logger.dart';
import 'module/module_di.dart';

List<ModuleBase> coreDIModule({bool debugMode = true}) => [
      ModuleBase.di(() async {
        registerSingleton<Client>(() => Client());
        registerDependency<Network>(() => AppNetwork(inject()));
      }),
      ModuleBase.boot((map) async {
        if (debugMode) {
          logger.register([DeveloperLogProvider()]);
        }
      }),
    ];
