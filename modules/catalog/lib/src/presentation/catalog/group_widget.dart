import 'package:core/core_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GroupList extends StatelessWidget {
  final List<String> _list;
  final Function(int) _callback;

  const GroupList(this._list, this._callback, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: AppColors.greyRegular),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      //color: AppColors.backgroundColor,
      child: Wrap(
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 0),
              alignment: Alignment.centerLeft,
              child: Text(
                "Grupos",
                style: AppStyle.h2().build(),
              )),
          const Divider(color: AppColors.greyRegular),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _list.length,
            itemBuilder: (BuildContext context, int index) {
              final item = _list[index];
              return GroupItem(item, () {
                _callback(index);
              });
            },
          ),
        ],
      ),
    );
  }
}

class GroupItem extends StatelessWidget {
  final String _item;
  final VoidCallback _callback;

  const GroupItem(this._item, this._callback, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: IntrinsicHeight(
        child: InkWell(
          onTap: () {
            _callback();
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Text("• $_item", style: AppStyle.p1().build(), overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension MoneyExt on double {
  String money() {
    return toStringAsFixed(2).replaceAll('.', ',');
  }
}
