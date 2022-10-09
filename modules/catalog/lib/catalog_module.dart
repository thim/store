import 'package:catalog/catalog_core.dart';
import 'package:core/core_flutter.dart';

import 'src/presentation/edit_page.dart';
import 'src/presentation/home_page.dart';

List<ModuleBase> catalogModule() => [
      ...catalogCoreModules(),
      ModuleRoute(() => {
            HomePage.route: (context) => const HomePage(),
            EditPage.route: (context) => const EditPage(),
          }),
    ];
