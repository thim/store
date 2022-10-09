import '../../domain/data.dart';

abstract class FieldValue {
  dynamic getValue();
}

class FieldNotifier {
  final BaasboxData item;
  final notifiers = <String, FieldValue>{};

  FieldNotifier(this.item);

  void register(String field, FieldValue value) {
    notifiers[field] = value;
  }

  Map<String, dynamic> getData() {
    final data = <String, dynamic>{};
    for (final key in notifiers.keys) {
      data[key] = notifiers[key]!.getValue();
    }

    return data;
  }
}
