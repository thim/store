import 'package:analytics_firebase/firebase_module.dart';
import 'package:authentication/auth_module.dart';
import 'package:catalog/catalog_module.dart';
import 'package:core/core_flutter.dart';
import 'package:flutter/material.dart';

import '../app_module.dart';

Future<void> bootStrap(BuildContext context) async {
  await Future.delayed(const Duration(seconds: 1));

  final boot = await flutterModule.init([firebaseModule, authModule, catalogModule, appModule]);

  final route = boot["initialRoute"] as RouteParams;

  Navigator.of(context).pushReplacementNamed(route.page, arguments: route.args);
}
