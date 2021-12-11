import 'package:core/src/core_di.dart';
import 'package:flutter/foundation.dart';

import '../core_flutter.dart';

List<ModuleBase> coreModule() => [...coreDIModule(debugMode: kDebugMode)];
