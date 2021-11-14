import 'dart:async';

import 'package:core/core.dart';
import 'package:core/core_flutter.dart';

class LoginBloc {
  final _navigateStream = StreamController<ScreenStep>.broadcast();

  final _messageStream = StreamController<String>.broadcast();

  Stream<ScreenStep> get navigate => _navigateStream.stream;

  Stream<String> get message => _messageStream.stream;

  ScreenStep step = ScreenStep.signOut;

  LoginBloc();

  void loginSendEmail(String user, String password) async {
    if (user == "user") {
      await flutterModule.moduleLifecycle.onUserUpdated(ModuleUserData("123", user));

      step = ScreenStep.signIn;
      _navigateStream.add(step);
    } else {
      _messageStream.add("Falha na autenticação. Dica: user / user.");
    }
  }

  void logout() {
    //_login.logout();
    _navigateStream.add(ScreenStep.signOut);
  }

  void dispose() {
    _navigateStream.close();
    _messageStream.close();
  }
}

enum ScreenStep { signOut, signIn }
