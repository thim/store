import 'dart:async';

import 'package:core/core.dart';

typedef LifecycleBuilder = LifecycleCallback Function();

abstract class LifecycleCallback {
  FutureOr<void> onPostInitialize() {}

  FutureOr<void> onUserUpdated(ModuleUserData userData) {}

  FutureOr<void> onLogout() {}
}

class ModuleUserData {
  final String id;
  final String userName;

  ModuleUserData(
    this.id,
    this.userName,
  );
}

abstract class ModuleLifecycle implements ModuleBase {
  LifecycleBuilder get lifecycle;
}

class LifecycleGroup {
  final List<LifecycleBuilder> _builders = [];

  List<LifecycleBuilder> get builders => _builders;

  LifecycleGroup();

  void register(ModuleLifecycle module) {
    _builders.add(module.lifecycle);
  }

  FutureOr<void> onUserUpdated(ModuleUserData userData) async {
    for (LifecycleBuilder module in _builders) {
      await module().onUserUpdated(userData);
    }
  }

  FutureOr<void> onLogout() async {
    for (LifecycleBuilder module in _builders) {
      await module().onLogout();
    }
  }
}
