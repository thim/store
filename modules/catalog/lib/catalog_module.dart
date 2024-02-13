import 'package:catalog/catalog_core.dart';
import 'package:core/core_flutter.dart';

import 'src/presentation/admin/catalog_page.dart';
import 'src/presentation/admin/edit_page.dart';
import 'src/presentation/user/home_page.dart';

List<ModuleBase> catalogModule() => [
      ...catalogCoreModules(),
      ModuleRoute(() => {
            CatalogPage.route: (context) => const CatalogPage(),
            EditPage.route: (context) => const EditPage(),
            HomePage.route: (context) => const HomePage(),
          }),
    ];
