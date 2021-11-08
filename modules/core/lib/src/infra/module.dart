import 'package:core/src/core_di.dart';

import 'injector.dart';

abstract class ModuleDI {
  void registerInject(AppInject injector);
}

void useModules(List<ModuleDI> modules) {
  CoreDI().registerInject(AppInject.instance);

  for (ModuleDI module in modules) {
    module.registerInject(AppInject.instance);
  }
}
