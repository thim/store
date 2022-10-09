import 'package:catalog/src/presentation/form/form_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'form_notifier.dart';

class MoneyWidget extends StatelessWidget implements FieldValue {
  final _controller = TextEditingController();
  final String title;
  final String field;

  MoneyWidget(this.field, this.title, FieldNotifier notifier, {Key? key}) : super(key: key) {
    _controller.text = notifier.item.getAsDouble(field).money();
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
        SizedBox(
          width: 200.0,
          child: TextField(
            key: ObjectKey(field),
            controller: _controller,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
            ],
            decoration: const InputDecoration(prefix: Text('\$')),
          ),
        ),
      ],
    );
  }

  @override
  getValue() => double.parse(_controller.text.replaceAll(".", "").replaceAll(",", "."));
}
