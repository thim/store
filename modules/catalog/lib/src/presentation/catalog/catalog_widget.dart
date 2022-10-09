import 'package:catalog/src/domain/data.dart';
import 'package:catalog/src/presentation/form/form_extension.dart';
import 'package:core/core_style.dart';
import 'package:flutter/material.dart';

import 'edit_widget.dart';

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
          final result = await EditWidget.openModal(context, _item, _groups);
          if (result != null) {
            _onEdit(result);
          }
        },
      ),
    );
  }
}
