import 'dart:developer';

abstract class LogProvider {
  Future<void> logError(String message);
}

class Logger {
  final List<LogProvider> _providers = [];

  void register(List<LogProvider> list) {
    _providers.addAll(list);
  }

  void sendEvent(String message) {
    for (LogProvider provider in _providers) {
      provider.logError(message);
    }
  }
}

final Logger logger = Logger();

class DeveloperLogProvider implements LogProvider {
  @override
  Future<void> logError(String message) async {
    log(message);
  }
}
