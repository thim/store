import 'dart:developer';

import 'package:core/core.dart';

class FirebaseProvider implements AnalyticsProvider {
  @override
  Future<void> sendEvent(TrackData data) async {
    log("${data.name} - ${data.params}", name: "FIREBASE_PROVIDER");
  }
}
