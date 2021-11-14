import 'package:authentication/src/domain/refresh_token_usecase.dart';

class RefreshToken implements RefreshTokenUseCase {
  @override
  Future<bool> call() {
    return Future.value(false);
  }
}
