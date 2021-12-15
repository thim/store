import 'package:analytics_firebase/src/firefake.dart';
import 'package:core/core.dart';

class FirebaseProvider implements AnalyticsProvider {
  @override
  Future<void> sendEvent(TrackData data) async {
    FireFake.instance.logDebug("${data.name} - ${data.params}");
  }
}
