import 'package:core/core_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login_bloc.dart';

class LoginPage extends StatefulWidget {
  static var route = "/login";

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();

  static args(String nextPage) => {"nextPage": nextPage};
}

class _LoginPageState extends State<LoginPage> {
  final _bloc = LoginBloc();
  final userController = TextEditingController(text: '');
  final passController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    _bloc.navigate.distinct().listen((value) {
      Navigator.of(context).pushReplacementNamed(args["nextPage"]);
    });

    _bloc.message.distinct().listen((message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    });

    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Material(
              child: Container(
                  alignment: Alignment.center,
                  color: AppColors.backgroundColor,
                  child: SizedBox(
                    width: constraints.maxWidth > 350 ? 350 : constraints.maxWidth,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                      children: [
                        const SizedBox(height: 24.0),
                        Text(
                          "Autenticar no sistema:",
                          style: AppStyle.p1().build(),
                        ),
                        const SizedBox(height: 24.0),
                        TextField(
                            key: const Key("user"),
                            keyboardType: TextInputType.emailAddress,
                            style: AppStyle.p1().build(),
                            autofocus: false,
                            decoration: const InputDecoration(hintText: 'Usuário'),
                            controller: userController),
                        const SizedBox(height: 16.0),
                        TextField(
                          key: const Key("pass"),
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          obscureText: true,
                          style: AppStyle.p1().build(),
                          decoration: const InputDecoration(hintText: 'Senha'),
                          controller: passController,
                        ),
                        const SizedBox(height: 24.0),
                        ElevatedButton(
                          onPressed: () {
                            switch (_bloc.step) {
                              case ScreenStep.signOut:
                                _bloc.loginSendEmail(userController.text, passController.text);
                                break;
                              case ScreenStep.signIn:
                                _bloc.logout();
                                break;
                            }
                          },
                          child: const Text("ENTRAR"),
                        ),
                      ],
                    ),
                  )),
            );
          },
        ));
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
