import 'package:core/core.dart';
import 'package:core/core_flutter.dart';

class AppDI implements ModuleDI, ModuleBoot {
  @override
  Future<void> registerInject(AppInject injector) async {}

  @override
  Future<void> boot(Map map) async {
    if (map["refreshed"]) {
      map["initialRoute"] = RouteParams("/home", {});
    } else {
      map["initialRoute"] = RouteParams("/login", {"nextPage": "/home"});
    }
  }
}
