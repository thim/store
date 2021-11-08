import 'package:catalog/catalog_module.dart';
import 'package:core/core.dart';
import 'package:core/core_flutter.dart';
import 'package:core/core_style.dart';
import 'package:flutter/material.dart';

import 'app_module.dart';

Future<void> main() async {
  useModules([AppModule(), CatalogModule()]);
  moduleRoutes([AppModule(), CatalogModule()]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store',
      theme: appTheme(context),
      initialRoute: "/splash",
      routes: moduleRoutes.routes,
    );
  }
}
