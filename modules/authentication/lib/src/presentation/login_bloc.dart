import 'dart:async';

import 'package:core/core.dart';
import 'package:core/core_flutter.dart';

import '../domain/authentication_usecase.dart';

class LoginBloc {
  final _authUseCase = inject<AuthenticationUseCase>();
  final _navigateStream = StreamController<ScreenStep>.broadcast();
  final _messageStream = StreamController<String>.broadcast();

  Stream<ScreenStep> get navigate => _navigateStream.stream;

  Stream<String> get message => _messageStream.stream;

  ScreenStep step = ScreenStep.signOut;

  LoginBloc();

  Future<void> login(String user, String password) async {
    final auth = await _authUseCase.login(user, password);

    if (auth) {
      analytics.sendEvent(TrackData("login_success", {"user": user}));

      await moduleLifecycle.onUserUpdated(ModuleUserData("123", user));

      step = ScreenStep.signIn;
      _navigateStream.add(step);
    } else {
      analytics.sendEvent(TrackData("login_fail", {"user": user}));
      _messageStream.add("Falha na autenticação. Dica: user / user.");
    }
  }

  void logout() {
    _authUseCase.logout();
    _navigateStream.add(ScreenStep.signOut);
  }

  void dispose() {
    _navigateStream.close();
    _messageStream.close();
  }
}

enum ScreenStep { signOut, signIn }
