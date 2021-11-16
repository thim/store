import 'package:http/http.dart';

import 'infra/network.dart';
import 'infra/network_impl.dart';
import 'module/module_di.dart';

List<ModuleBase> coreDIModule() => [
      ModuleBase.di((injector) async {
        injector.registerSingleton<Client>(() => Client());
        injector.registerDependency<Network>(() => AppNetwork(injector()));
      }),
    ];
