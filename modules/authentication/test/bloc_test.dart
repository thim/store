import 'dart:async';

import 'package:authentication/auth_core.dart';
import 'package:authentication/src/presentation/login_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final analyticsMock = AnalyticsMock();

  group('Bloc Group', () {
    setUpAll(() async {
      await CoreModule().init([authCoreModules]);
      analytics.register([analyticsMock]);
    });

    setUp(() {
      analyticsMock.clear();
    });

    test("authentication failed", () async {
      final bloc = LoginBloc();
      final completer = Completer<String>();

      bloc.message.listen((event) {
        completer.complete(event);
      });

      await bloc.login("wrongUser", "wrongPassword");

      expect(analyticsMock.counter, 1);
      expect(
        analyticsMock.data?.name,
        "login_fail",
      );
      expect(await completer.future, "Falha na autenticação. Dica: user / user.");
    });

    test("authentication successful", () async {
      final bloc = LoginBloc();
      final completer = Completer<ScreenStep>();

      bloc.navigate.listen((event) {
        completer.complete(event);
      });

      await bloc.login("user", "password");

      expect(analyticsMock.counter, 1);
      expect(
        analyticsMock.data?.name,
        "login_success",
      );
      expect(await completer.future, ScreenStep.signIn);
    });
  });
}

class AnalyticsMock implements AnalyticsProvider {
  int counter = 0;
  TrackData? data;

  void clear() {
    counter = 0;
    data = null;
  }

  @override
  Future<void> sendEvent(TrackData data) async {
    counter++;
    this.data = data;
  }
}
