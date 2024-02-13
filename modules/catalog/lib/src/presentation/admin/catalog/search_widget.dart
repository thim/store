import 'package:core/core_style.dart';
import 'package:flutter/material.dart';

import '../catalog_bloc.dart';

class SearchBox extends StatelessWidget {
  final textController = TextEditingController(text: '');
  final CatalogBloc _bloc;

  SearchBox(this._bloc, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: AppColors.greyRegular),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: AppColors.backgroundColor,
        ),
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        //padding: EdgeInsets.all(12),
        child: TextField(
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide.none),
            focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide.none),
            hintText: 'Buscar',
            suffixIcon: IconButton(
              onPressed: () {
                _bloc.search(textController.text);
              },
              icon: const Icon(Icons.search),
            ),
          ),
          controller: textController,
          maxLines: 1,
          onSubmitted: (value) {
            _bloc.search(value);
            textController.clear();
          },
        ),
      ),
    );
  }
}
