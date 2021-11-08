abstract class Network {
  Future<NetworkResponse> get({required Uri url, Map<String, String>? headers});
}

class NetworkResponse {
  final int statusCode;
  final String body;

  NetworkResponse(this.statusCode, this.body);

  bool get isSuccess => statusCode == 200;
}
