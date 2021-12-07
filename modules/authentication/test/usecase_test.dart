import 'package:authentication/auth_core.dart';
import 'package:authentication/src/domain/authentication_usecase.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Use Case Group', () {
    setUpAll(() async {
      await CoreModule().init([authCoreModules]);
    });

    test("authentication failed", () async {
      final useCase = inject<AuthenticationUseCase>();
      expect(await useCase.login("wrongUser", "password"), false);
    });

    test("authentication successful", () async {
      final useCase = inject<AuthenticationUseCase>();
      expect(await useCase.login("user", "password"), true);
    });
  });
}
