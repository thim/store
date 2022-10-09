import 'package:catalog/src/domain/data.dart';
import 'package:core/core_style.dart';
import 'package:flutter/material.dart';

import '../form/form_combo.dart';
import '../form/form_money.dart';
import '../form/form_notifier.dart';
import '../form/form_text.dart';

class EditWidget extends StatelessWidget {
  final BaasboxData _item;
  final List<BaasboxData> _groups;

  const EditWidget(this._item, this._groups, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifier = FieldNotifier(_item);

    return Container(
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
              ComboWidget('group', "Grupo", _groups, (value) => value.getAsString("name"), notifier),
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
                    Navigator.pop(context, data);
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
    );
  }

  static Future<BaasboxData?> openModal(BuildContext context, BaasboxData item, List<BaasboxData> _groups) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: EditWidget(item, _groups),
        ),
      ),
    );
  }
}
