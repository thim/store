// ignore_for_file: avoid_print

import 'dart:io';

import 'package:analytics_firebase/firebase_core.dart';
import 'package:app/app_core.dart';
import 'package:authentication/auth_core.dart';
import 'package:catalog/catalog_core.dart';
import 'package:core/core.dart';

void main() async {
  print("Store - terminal");

  final boot = await CoreModule().init([firebaseCoreModule, authCoreModules, catalogCoreModules, appCoreModules]);

  final route = boot["initialRoute"] as RouteParams;
  print("route = ${route.page} ${route.args}");

  exit(0);
}
