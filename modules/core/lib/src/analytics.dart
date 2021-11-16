abstract class AnalyticsProvider {
  Future<void> sendEvent(TrackData data);
}

class TrackData {
  final String name;
  final Map<String, Object> params;

  TrackData(this.name, this.params);
}

class Analytics {
  final List<AnalyticsProvider> _providers = [];

  void register(List<AnalyticsProvider> list) {
    _providers.addAll(list);
  }

  Future<void> sendEvent(TrackData data) async {
    for (AnalyticsProvider provider in _providers) {
      await provider.sendEvent(data);
    }
  }
}

final Analytics analytics = Analytics();
