import 'package:core/core_flutter.dart';
import 'package:core/core_style.dart';
import 'package:flutter/material.dart';

import 'src/presentation/splash.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store',
      theme: appTheme(context),
      home: const SplashPage(),
      routes: flutterModule.moduleRoutes.routes,
    );
  }
}
