import 'dart:developer';

class FireFake {
  static FireFake instance = FireFake();

  static String? _user;

  void setUser(String username) {
    _user = username;
    log("Setting user to:[$_user]", name: "FireFake");
  }

  void clear() {
    _user = null;
  }

  void logDebug(String message) {
    log(message, name: "FireFake");
  }
}
