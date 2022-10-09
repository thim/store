import 'package:core/core_style.dart';
import 'package:flutter/material.dart';

import '../../domain/data.dart';
import 'form_notifier.dart';

class ComboWidget extends StatelessWidget implements FieldValue {
  final ValueNotifier<String> _valueGroup = ValueNotifier<String>("");
  final List<BaasboxData> values;
  final String title;
  final String field;
  final String Function(BaasboxData) transform;

  ComboWidget(this.field, this.title, this.values, this.transform, FieldNotifier notifier, {Key? key}) : super(key: key) {
    _valueGroup.value = transform(values.first);
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
          child: AnimatedBuilder(
            // [AnimatedBuilder] accepts any [Listenable] subtype.
            animation: _valueGroup,
            builder: (BuildContext context, Widget? child) {
              return DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)), border: Border.all(color: AppColors.queenBlue)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 3.0, 4.0, 3.0),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: Container(),
                    value: _valueGroup.value,
                    onChanged: (String? value) {
                      _valueGroup.value = value!;
                    },
                    items: values.map<DropdownMenuItem<String>>((BaasboxData value) {
                      return DropdownMenuItem<String>(
                        value: transform(value),
                        child: Text(transform(value)),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  getValue() => _valueGroup.value;
}
