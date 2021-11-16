import '../module/module_di.dart';
import 'module_routes.dart';

class ModuleBuild {
  final List<ModuleBase> modules;

  String get id => runtimeType.toString();

  ModuleBuild(this.modules);
}

class FlutterModule extends CoreModule {
  @override
  Future<Map> init(List<ModuleBuilder> builders) {
    final map = super.init(builders);

    final modules = builders.map((build) => build.call()).expand((module) => module);
    for (ModuleBase module in modules) {
      if (module is ModuleRoute) {
        moduleRoutes.register(module);
      }
    }

    return map;
  }
}

final flutterModule = FlutterModule();
