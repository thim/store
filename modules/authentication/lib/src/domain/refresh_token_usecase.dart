abstract class RefreshTokenUseCase {
  Future<bool> call();
}

class RefreshToken implements RefreshTokenUseCase {
  @override
  Future<bool> call() {
    return Future.value(false);
  }
}