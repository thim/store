import 'package:catalog/src/domain/mock.dart';
import 'package:core/core_style.dart';
import 'package:flutter/material.dart';

import '../domain/data.dart';
import 'catalog/catalog_widget.dart';
import 'catalog/edit_widget.dart';
import 'catalog/group_widget.dart';
import 'catalog/search_widget.dart';
import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  static var route = "/home";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final _bloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.queenBlue,
      child: Row(
        children: [
          Menu(_bloc),
          GroupPage(_bloc),
          Flexible(
              child: Column(
            children: [
              SearchBox(_bloc),
              FilterPage(_bloc),
              Expanded(child: ListPage(_bloc)),
            ],
          ))
        ],
      ),
    );
  }

  @override
  void initState() {
    _bloc.loadData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}

class Menu extends StatelessWidget {
  final HomeBloc _bloc;

  const Menu(this._bloc, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: 50,
        color: AppColors.queenBlue,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(25.0),
                child: const Icon(
                  Icons.add,
                  color: AppColors.honeydew,
                  size: 24.0,
                ),
                onTap: () async {
                  final result = await EditWidget.openModal(context, BaasboxData(id: "123", fields: {}), mockGroup);
                  if (result != null) {
                    _bloc.add(result);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GroupPage extends StatefulWidget {
  final HomeBloc _bloc;

  const GroupPage(this._bloc, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GroupPageState();
  }
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.backgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.horizontal(left: Radius.circular(8.0), right: Radius.zero),
          ),
          alignment: Alignment.topLeft,
          width: constraints.maxWidth > 250 ? 250 : constraints.maxWidth,
          child: StreamBuilder<List<String>>(
              stream: widget._bloc.group,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GroupList(snapshot.data!, (i) {
                    widget._bloc.filterBy(i);
                  });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        );
      }),
    );
  }
}

class ListPage extends StatefulWidget {
  final HomeBloc _bloc;

  const ListPage(this._bloc, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListPageState();
  }
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      color: AppColors.backgroundColor,
      child: StreamBuilder<List<BaasboxData>>(
          stream: widget._bloc.data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CatalogList(
                snapshot.data!,
                mockGroup,
                (item) {
                  widget._bloc.delete(item.id);
                },
                (item) {
                  widget._bloc.edit(item);
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    ));
  }
}

class FilterPage extends StatefulWidget {
  final HomeBloc _bloc;

  const FilterPage(this._bloc, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FilterPageState();
  }
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
      color: AppColors.backgroundColor,
      child: StreamBuilder<String>(
          stream: widget._bloc.filter,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data?.isNotEmpty == true) {
              return Chip(
                backgroundColor: AppColors.queenBlue,
                deleteIcon: const Icon(
                  Icons.clear,
                  color: AppColors.white,
                ),
                label: Text(
                  snapshot.data!,
                  style: const TextStyle(color: AppColors.white),
                ),
                onDeleted: () {
                  widget._bloc.clear();
                },
              );
            } else {
              return Container();
            }
          }),
    ));
  }
}
