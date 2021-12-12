abstract class AuthenticationUseCase {
  Future<bool> login(String user, String password);

  Future<bool> logout();
}

class Authentication implements AuthenticationUseCase {
  @override
  Future<bool> login(String user, String password) async {
    if (user == "user") {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    return true;
  }
}
