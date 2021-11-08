import 'package:http/http.dart';

import 'infra/injector.dart';
import 'infra/module.dart';
import 'infra/network.dart';
import 'infra/network_impl.dart';

class CoreDI implements ModuleDI {
  @override
  void registerInject(AppInject injector) {
    injector.registerSingleton<Client>(() => Client());
    injector.registerDependency<Network>(() => AppNetwork(injector()));
  }
}
