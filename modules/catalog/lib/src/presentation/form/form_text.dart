import 'package:flutter/material.dart';

import 'form_notifier.dart';

class FieldWidget extends StatelessWidget implements FieldValue {
  final _controller = TextEditingController();
  final String title;
  final String field;
  final int maxLine;

  FieldWidget(this.field, this.title, FieldNotifier notifier, {Key? key, this.maxLine = 1}) : super(key: key) {
    _controller.text = notifier.item.getAsString(field);
    notifier.register(field, this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
          child: Text(title),
        ),
        TextField(
          key: ObjectKey(field),
          controller: _controller,
          maxLines: maxLine,
        ),
      ],
    );
  }

  @override
  getValue() => _controller.text;
}
