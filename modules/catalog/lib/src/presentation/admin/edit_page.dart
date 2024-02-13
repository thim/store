import 'package:catalog/src/domain/mock.dart';
import 'package:core/core_style.dart';
import 'package:flutter/material.dart';

import '../../domain/data.dart';
import '../form/form_combo.dart';
import '../form/form_money.dart';
import '../form/form_notifier.dart';
import '../form/form_text.dart';

class EditPage extends StatefulWidget {
  static var route = "/edit";

  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final BaasboxData _item = mockList.first;

  @override
  Widget build(BuildContext context) {
    final Object? settingsArgs = ModalRoute.of(context)?.settings.arguments;
    final args = settingsArgs is Map ? settingsArgs : {};

    final notifier = FieldNotifier(_item);
    return Material(
      child: Container(
        width: 700.0,
        margin: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FieldWidget("title", "Título", notifier),
            FieldWidget("code", "Código", notifier),
            FieldWidget(
              "detail",
              "Detalhes",
              notifier,
              maxLine: 6,
            ),
            Row(
              children: [
                ComboWidget('group', "Grupo", mockGroup, (value) => value.getAsString("name"), notifier),
                const SizedBox(
                  width: 12.0,
                ),
                MoneyWidget("price", "Preço", notifier),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: const Text("Salvar"),
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16.0), primary: AppColors.white, backgroundColor: AppColors.buttonColor),
                    onPressed: () {
                      final data = BaasboxData(id: _item.id, fields: notifier.getData());
                      print('${data.fields.toString()}');
                      //Navigator.pop(context, data);
                    },
                  ),
                  TextButton(
                    child: const Text("Cancelar"),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: AppColors.buttonColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
