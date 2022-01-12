import 'dart:async';

import 'package:authentication/auth_core.dart';
import 'package:authentication/src/presentation/login_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../core/test/mock.dart';

class AnalyticsMock extends Mock implements AnalyticsProvider {}

void main() {
  final analyticsMock = AnalyticsMock();

  group('Bloc Group', () {
    setUpAll(() async {
      await CoreModule().init([authCoreModules]);
      analytics.register([analyticsMock]);
    });

    setUp(() {
      clearMock();
    });

    test("authentication failed", () async {
      final bloc = LoginBloc();
      final completer = Completer<String>();

      bloc.message.listen((event) {
        completer.complete(event);
      });

      mock<Future<void>>(analyticsMock.sendEvent, () {
        return Future.value();
      });

      await bloc.login("wrongUser", "wrongPassword");

      expect(await completer.future, "Falha na autenticação. Dica: user / user.");

      verify(analyticsMock.sendEvent, 1);

      check<TrackData>((param) => param.name == "login_fail");
    });

    test("authentication successful", () async {
      final bloc = LoginBloc();
      final completer = Completer<ScreenStep>();

      bloc.navigate.listen((event) {
        completer.complete(event);
      });

      mock<Future<void>>(analyticsMock.sendEvent, () {
        return Future.value();
      });

      await bloc.login("user", "password");

      verify(analyticsMock.sendEvent, 1);

      check<TrackData>((param) => param.name == "login_success");

      expect(await completer.future, ScreenStep.signIn);
    });
  });
}
