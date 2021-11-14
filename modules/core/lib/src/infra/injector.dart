import 'package:injector/injector.dart';

typedef InjectBuilder<T> = T Function();

class AppInject {
  AppInject._();

  static AppInject instance = AppInject._();

  final Injector _injector = Injector.appInstance;

  void registerDependency<T>(InjectBuilder<T> builder, {bool override = false, String dependencyName = ""}) {
    _injector.registerDependency(builder, override: override, dependencyName: dependencyName);
  }

  void registerSingleton<T>(InjectBuilder<T> builder, {bool override = false, String dependencyName = ""}) {
    _injector.registerSingleton(builder, override: override, dependencyName: dependencyName);
  }

  T get<T>({String dependencyName = ""}) {
    return _injector.get(dependencyName: dependencyName);
  }

  T call<T>([String instanceName = ""]) {
    return get<T>(dependencyName: instanceName);
  }
}

T inject<T>() {
  return AppInject.instance.get<T>();
}

void registerDependency<T>(InjectBuilder<T> builder) {
  AppInject.instance.registerDependency<T>(builder);
}

void registerSingleton<T>(InjectBuilder<T> builder, {bool override = false}) {
  AppInject.instance.registerSingleton<T>(builder, override: override);
}
