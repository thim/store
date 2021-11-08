import 'package:catalog/catalog_core.dart';
import 'package:core/core_flutter.dart';
import 'package:flutter/widgets.dart';

import 'src/presentation/home_page.dart';

class CatalogModule with CatalogDI implements ModuleRoute {
  @override
  Map<String, WidgetBuilder> routes() => {HomePage.route: (context) => const HomePage()};
}
