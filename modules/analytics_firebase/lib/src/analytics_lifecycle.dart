import 'dart:async';

import 'package:analytics_firebase/src/firefake.dart';
import 'package:core/core.dart';

class AnalyticsLifecycle implements LifecycleCallback {
  @override
  FutureOr<void> onPostInitialize() {}

  @override
  FutureOr<void> onUserUpdated(ModuleUserData userData) {
    FireFake.instance.setUser(userData.userName);
  }

  @override
  FutureOr<void> onLogout() {
    FireFake.instance.clear();
  }
}
