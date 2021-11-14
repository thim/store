import 'package:core/src/core_di.dart';

import '../infra/injector.dart';

abstract class ModuleDI {
  Future<void> registerInject(AppInject injector);
}

Future<void> initModules(Iterable<ModuleDI> modules) async {
  await CoreDI().registerInject(AppInject.instance);

  for (ModuleDI module in modules) {
    await module.registerInject(AppInject.instance);
  }
}
