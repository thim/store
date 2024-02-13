import 'dart:async';
import 'dart:collection';
import 'dart:developer';

import '../../domain/data.dart';
import '../../domain/mock.dart';

class CatalogBloc {
  final _data = StreamController<List<BaasboxData>>.broadcast();
  final _group = StreamController<List<String>>.broadcast();
  final _filter = StreamController<String>.broadcast();

  Stream<List<BaasboxData>> get data => _data.stream;

  Stream<List<String>> get group => _group.stream;

  Stream<String> get filter => _filter.stream;

  final List<BaasboxData> _cache = [];
  final List<String> _cacheGroup = [];

  CatalogBloc();

  void loadData() async {
    await Future.delayed(const Duration(seconds: 1));

    log("loadData");
    _cache.addAll(mockList);
    final groups = LinkedHashSet<String>.from(_cache.map((e) => e.getAsString("group"))).toList();
    groups.insert(0, "Todos");
    _cacheGroup.clear();
    _cacheGroup.addAll(groups);
    _group.add(groups);
    _data.add(_cache);
  }

  Future<void> dispose() async {
    await _data.close();
    await _group.close();
    await _filter.close();
  }

  void search(String text) async {
    _filter.add(text);
    _data.add(_cache.where((e) => e.fields["title"].toLowerCase().contains(text.toLowerCase())).toList());
  }

  void filterBy(int index) async {
    if (index == 0) {
      clear();
    } else {
      final group = _cacheGroup[index];
      _data.add(_cache.where((e) => e.fields["group"] == group).toList());
      _filter.add(group);
    }
  }

  void delete(String id) {
    final result = _cache.firstWhere((element) => element.id == id);
    _cache.remove(result);

    _filter.add("");
    _data.add(_cache);
  }

  void add(BaasboxData data) {
    _cache.add(data);
    _data.add(_cache);
  }

  void edit(BaasboxData data) {
    final index = _cache.indexWhere((element) => element.id == data.id);
    if (index > -1) {
      _cache[index] = data;
      _data.add(_cache);
    }
  }

  void clear() {
    _filter.add("");
    _data.add(_cache);
  }
}
