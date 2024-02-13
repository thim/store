import 'package:authentication/auth_core.dart';
import 'package:core/core.dart';

List<ModuleBase> appCoreModules() => [
      ModuleBase.boot((map) async {
        if (map[refreshedKey]) {
          map[initialRouteKey] = RouteParams("/home", {});
        } else {
          map[initialRouteKey] = RouteParams("/home", {});
          //map[initialRouteKey] = RouteParams("/login", {"nextPage": "/home"});
        }
      }),
    ];

const String initialRouteKey = "initialRoute";
