import 'package:core/core.dart';

List<ModuleBase> appCoreModules() => [
      ModuleBase.boot((map) async {
        if (map["refreshed"]) {
          map["initialRoute"] = RouteParams("/home", {});
        } else {
          map["initialRoute"] = RouteParams("/login", {"nextPage": "/home"});
        }
      }),
    ];
