import 'package:catalog/src/domain/data.dart';
import 'package:catalog/src/presentation/form/form_extension.dart';
import 'package:core/core_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CatalogList extends StatelessWidget {
  final List<BaasboxData> _list;
  final List<BaasboxData> _groups;
  final Function(BaasboxData) _onDelete;
  final Function(BaasboxData) _onEdit;

  const CatalogList(this._list, this._groups, this._onDelete, this._onEdit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: AppColors.greyRegular),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(1),
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 1,
          thickness: 1,
          color: AppColors.greyRegular,
        ),
        itemCount: _list.length,
        itemBuilder: (context, index) {
          final item = _list[index];
          return CatalogItem(item, _groups, () {
            _onDelete(item);
          }, _onEdit);
        },
      ),
    );
  }
}

class CatalogItem extends StatelessWidget {
  final BaasboxData _item;
  final List<BaasboxData> _groups;
  final Function() _onDelete;
  final Function(BaasboxData) _onEdit;

  const CatalogItem(this._item, this._groups, this._onDelete, this._onEdit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.backgroundColor,
      child: InkWell(
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          height: 92,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${_item.fields["title"]}",
                        style: AppStyle.p1().medium.build(),
                        maxLines: 1,
                      ),
                      Text(
                        "${_item.fields["detail"]}",
                        style: AppStyle.p2().withColor(AppColors.queenBlue).build(),
                        maxLines: 2,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "\$ ${_item.getAsDouble("price").money()}",
                  style: AppStyle.p1().medium.withColor(AppColors.desire).build(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(25.0),
                  child: const Icon(
                    Icons.delete,
                    color: AppColors.queenBlue,
                    size: 24.0,
                  ),
                  onTap: () {
                    _onDelete();
                  },
                ),
              )
            ],
          ),
        ),
        onTap: () async {
          final result = await openModal(context, _item, _groups);
          if (result != null) {
            _onEdit(result);
          }
        },
      ),
    );
  }
}

Future<BaasboxData?> openModal(BuildContext context, BaasboxData item, List<BaasboxData> _groups) async {
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
        child: DetailItem(item, _groups),
      ),
    ),
  );
}

class DetailItem extends StatelessWidget {
  final BaasboxData _item;
  final List<BaasboxData> _groups;

  const DetailItem(this._item, this._groups, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: "${_item.fields["title"] ?? ""}");
    final detailController = TextEditingController(text: "${_item.fields["detail"] ?? ""}");
    final codeController = TextEditingController(text: "${_item.fields["code"] ?? ""}");
    final priceController = TextEditingController(text: _item.getAsDouble("price").money());

    final ValueNotifier<String> valueGroup = ValueNotifier<String>("Grupo 1");

    return Container(
      width: 700.0,
      margin: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
            child: Text("Título"),
          ),
          TextField(key: const ObjectKey("TITLE"), controller: titleController),
          const Padding(
            padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
            child: Text("Código"),
          ),
          TextField(
            key: const ObjectKey("CODE"),
            controller: codeController,
            maxLines: 1,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
            child: Text("Detalhes"),
          ),
          TextField(
            key: const ObjectKey("DETAIL"),
            controller: detailController,
            maxLines: 6,
          ),
          Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                    child: Text("Grupo"),
                  ),
                  SizedBox(
                    width: 200.0,
                    child: AnimatedBuilder(
                      // [AnimatedBuilder] accepts any [Listenable] subtype.
                      animation: valueGroup,
                      builder: (BuildContext context, Widget? child) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5.0)), border: Border.all(color: AppColors.queenBlue)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 3.0, 4.0, 3.0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: Container(),
                              value: valueGroup.value,
                              onChanged: (String? value) {
                                valueGroup.value = value!;
                              },
                              items: _groups.map<DropdownMenuItem<String>>((BaasboxData value) {
                                return DropdownMenuItem<String>(
                                  value: value.getAsString('name'),
                                  child: Text(value.getAsString('name')),
                                );
                              }).toList(),
                            ),
                          ),
                        );

                        //Text('${counterValueNotifier.value}');
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 12.0,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                    child: Text("Preço"),
                  ),
                  SizedBox(
                    width: 200.0,
                    child: TextField(
                      key: const ObjectKey("PRICE"),
                      controller: priceController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                      ],
                      decoration: const InputDecoration(prefix: Text('\$')),
                    ),
                  ),
                ],
              ),
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
                    final data = BaasboxData(id: _item.id, fields: {
                      'title': titleController.text,
                      'code': codeController.text,
                      'detail': detailController.text,
                      'price': double.parse(priceController.text.replaceAll(".", "").replaceAll(",", ".")),
                    });
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
}
