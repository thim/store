import 'package:core/core_style.dart';
import 'package:flutter/material.dart';

class GroupList extends StatefulWidget {
  final List<String> _list;
  final Function(int) _callback;

  const GroupList(this._list, this._callback, {Key? key}) : super(key: key);

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: widget._list.length,
      itemBuilder: (BuildContext context, int index) {
        final item = widget._list[index];
        return GroupItem(item, selected == index, () {
          selected = index;
          setState(() {});
          widget._callback(index);
        });
      },
    );
  }
}

class GroupItem extends StatelessWidget {
  final String _item;
  final bool _selected;
  final VoidCallback _callback;

  const GroupItem(this._item, this._selected, this._callback, {Key? key}) : super(key: key);

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
            height: 80.0,
            alignment: Alignment.center,
            color: _selected ? AppColors.backgroundColor : AppColors.queenBlue,
            child: Text(_item,
                style: AppStyle.p1().withColor(_selected ? AppColors.queenBlue : AppColors.backgroundColor).build(),
                overflow: TextOverflow.ellipsis),
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
