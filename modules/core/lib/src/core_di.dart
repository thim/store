import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../core.dart';
import 'infra/network.dart';
import 'infra/network_impl.dart';
import 'logger.dart';
import 'module/module_di.dart';

List<ModuleBase> coreDIModule() =>
    [
      ModuleBase.di(() async {
        registerSingleton<Client>(() => Client());
        registerDependency<Network>(() => AppNetwork(inject()));
      }),
      ModuleBase.boot((map) async {
        if (kDebugMode) {
          logger.register([DeveloperLogProvider()]);
        }
      }),
    ];
