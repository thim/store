import '../core_di.dart';
import '../infra/injector.dart';
import '../module/module_di.dart';
import '../module/module_lifecycle.dart';
import 'module_boot.dart';
import 'module_routes.dart';

class FlutterModule {
  final moduleRoutes = RouteGroup();
  final moduleLifecycle = LifecycleGroup();

  Future<Map> init(List<ModuleDI> modules) async {
    await CoreDI().registerInject(AppInject.instance);

    for (ModuleDI module in modules) {
      await module.registerInject(AppInject.instance);

      if (module is ModuleRoute) {
        moduleRoutes.register(module as ModuleRoute);
      }

      if (module is ModuleLifecycle) {
        moduleLifecycle.register(module as ModuleLifecycle);
      }
    }

    final Map result = {};
    for (ModuleBoot module in modules.whereType<ModuleBoot>()) {
      await module.boot(result);
    }

    return result;
  }
}

final flutterModule = FlutterModule();
