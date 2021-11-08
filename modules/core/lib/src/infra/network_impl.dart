import 'package:http/http.dart';

import 'network.dart';

class AppNetwork implements Network {
  final Client _client;

  AppNetwork(this._client);

  @override
  Future<NetworkResponse> get({required Uri url, Map<String, String>? headers}) async {
    final response = await _client.get(url, headers: headers);
    return NetworkResponse(response.statusCode, response.body);
  }
}
