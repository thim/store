import 'package:analytics_firebase/src/analytics_lifecycle.dart';
import 'package:core/core.dart';

import 'src/firebase_provider.dart';

List<ModuleBase> firebaseCoreModule() =>
    [
      ModuleBase.boot((map) async {
        analytics.register([FirebaseProvider()]);
      }),
      ModuleBase.lifecycle(() => AnalyticsLifecycle())
    ];
