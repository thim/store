import 'package:authentication/auth_core.dart';
import 'package:authentication/src/domain/authentication_usecase.dart';
import 'package:authentication/src/presentation/login_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../core/test/mock.dart';

void main() {
  final loginMock = FakeAuthentication();

  group('Widget Group', () {
    setUpAll(() async {
      await CoreModule().init([authCoreModules]);
      registerDependency<AuthenticationUseCase>(() => loginMock, override: true);
    });

    setUp(() => clearMock());

    testWidgets('authentication successful', (WidgetTester tester) async {
      mock<Future<bool>>(loginMock.login, () {
        return Future.value(true);
      });

      final routeObserver = MyRouteObserver();

      await tester.pumpWidget(MaterialApp(
        navigatorObservers: [routeObserver],
        onGenerateRoute: (route) {
          return MaterialPageRoute<Widget>(
            builder: (_) => const LoginPage(),
            settings: RouteSettings(name: route.name, arguments: const {"nextPage": "/home"}),
          );
        },
      ));

      // Verify that our counter starts at 0.
      expect(find.text('Autenticar no sistema:'), findsOneWidget);

      await tester.enterText(find.byKey(const Key("user")), 'user');
      await tester.enterText(find.byKey(const Key("pass")), 'pass');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(routeObserver.lastScreen, "/home");
    });

    testWidgets('authentication failed', (WidgetTester tester) async {
      // mock<Future<bool>>(loginMock.login, () {
      //   return Future.value(false);
      // });

      await tester.pumpWidget(MaterialApp(
        home: Navigator(
          onGenerateRoute: (_) {
            return MaterialPageRoute<Widget>(
              builder: (_) => const LoginPage(),
              settings: const RouteSettings(arguments: {"nextPage": "/home"}),
            );
          },
        ),
      ));

      // Verify that our counter starts at 0.
      expect(find.text('Autenticar no sistema:'), findsOneWidget);

      await tester.enterText(find.byKey(const Key("user")), 'wrongUser');
      await tester.enterText(find.byKey(const Key("pass")), 'wrongPass');

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Falha na autenticação. Dica: user / user.'), findsOneWidget);
    });
  });
}

class MyRouteObserver extends NavigatorObserver {
  String? lastScreen;

  void _sendScreenView(PageRoute<dynamic> route) {
    lastScreen = route.settings.name;
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }
  }
}

class FakeAuthentication extends Mock implements AuthenticationUseCase {}

class FakeAuthentication2 implements AuthenticationUseCase {
  final bool loginResult;

  FakeAuthentication2(this.loginResult);

  @override
  Future<bool> login(String user, String password) async {
    return loginResult;
  }

  @override
  Future<bool> logout() async {
    return true;
  }
}
