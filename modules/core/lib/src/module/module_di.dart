import '../core_di.dart';
import 'module_lifecycle.dart';

abstract class ModuleBase {
  factory ModuleBase.di(Future<void> Function() func) => ModuleDI(func);

  factory ModuleBase.boot(Future<void> Function(Map) func) => ModuleBoot(func);
}

class ModuleDI implements ModuleBase {
  final Future<void> Function() _run;

  ModuleDI(this._run);

  Future<void> run() => _run();
}

class ModuleBoot implements ModuleBase {
  final Future<void> Function(Map) _run;

  ModuleBoot(this._run);

  Future<void> run(Map map) => _run(map);
}

typedef ModuleBuilder = List<ModuleBase> Function();

class CoreModule {
  Future<Map> init(List<ModuleBuilder> builders) async {
    builders.insert(0, coreDIModule);
    final modules = builders.map((build) => build.call()).expand((module) => module);

    for (ModuleBase module in modules) {
      if (module is ModuleDI) {
        await module.run();
      }

      if (module is ModuleLifecycle) {
        moduleLifecycle.register(module);
      }
    }

    final Map result = {};
    for (ModuleBoot module in modules.whereType<ModuleBoot>()) {
      await module.run(result);
    }

    return result;
  }
}

final moduleLifecycle = LifecycleGroup();
