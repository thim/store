import 'dart:async';

import 'package:http/http.dart';

import 'infra/injector.dart';
import 'infra/network.dart';
import 'infra/network_impl.dart';
import 'module/module_di.dart';
import 'module/module_lifecycle.dart';

class CoreDI implements ModuleDI, ModuleLifecycle {
  @override
  Future<void> registerInject(AppInject injector) async {
    injector.registerSingleton<Client>(() => Client());
    injector.registerDependency<Network>(() => AppNetwork(injector()));
  }

  @override
  LifecycleBuilder get lifecycle => () => CoreLifecycle();
}

class CoreLifecycle implements LifecycleCallback {
  @override
  FutureOr<void> onUserUpdated(ModuleUserData userData) {}

  @override
  FutureOr<void> onLogout() {}

  @override
  FutureOr<void> onPostInitialize() {}
}
