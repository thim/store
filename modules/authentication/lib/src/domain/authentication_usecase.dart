abstract class AuthenticationUseCase {
  Future<bool> login(String user, String password);

  Future<bool> logout();
}
