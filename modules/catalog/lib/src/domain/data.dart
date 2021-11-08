class BaasboxData {
  final String id;
  final Map<String, dynamic> fields;

  BaasboxData({required this.id, required this.fields});

  factory BaasboxData.fromJson(Map<String, dynamic> json) {
    final result = BaasboxData(id: json["_id"], fields: json);

    result.fields.remove("_id");
    return result;
  }

  double getAsDouble(String field) {
    final val = fields[field];
    return val is double ? val : 0.0;
  }

  String getAsString(String field) => fields[field];

  String operator [](String field) {
    return fields[field];
  }
}
