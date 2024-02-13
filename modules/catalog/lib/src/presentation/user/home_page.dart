import 'package:core/core_style.dart';
import 'package:flutter/material.dart';

import '../../domain/data.dart';
import 'group_widget.dart';
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
      child: Column(
        children: [
          Header(_bloc),
          Container(
            height: 2.0,
            color: AppColors.queenBlue,
          ),
          Expanded(
            child: Row(
              children: [
                Menu(_bloc),
                //GroupPage(_bloc),
                //Container(width: 2.0, color: AppColors.queenBlue,),
                Expanded(child: ListPage(_bloc))
              ],
            ),
          ),
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
        //alignment: Alignment.topLeft,
        width: 200,
        child: StreamBuilder<List<String>>(
            stream: _bloc.group,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GroupList(snapshot.data!, (i) {
                  //widget._bloc.filterBy(i);
                });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final HomeBloc _bloc;

  const Header(this._bloc, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 60,
        color: AppColors.backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: AppColors.desire,
              alignment: Alignment.center,
              width: 300.0,
              child: Text('LOGO'),
            ),
            Expanded(child: Container()),
            SizedBox(
              width: 200.0,
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: AppColors.greyRegular,
                  ),
                  padding: const EdgeInsets.all(4.0),
                  child: const Text(
                    'mesa 11',
                  ),
                ),
              ),
            ),
            const VerticalDivider(
              thickness: 1.0,
              width: 2,
              color: AppColors.deepKoamaru,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(25.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: AppColors.queenBlue,
                      size: 24.0,
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      'Busca',
                      style: AppStyle.p2().withColor(AppColors.queenBlue).build(),
                    ),
                  ],
                ),
                onTap: () async {},
              ),
            ),
            const VerticalDivider(
              thickness: 1.0,
              width: 2,
              color: AppColors.deepKoamaru,
            ),
            Container(
              color: AppColors.queenBlue,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: InkWell(
                // borderRadius: BorderRadius.circular(25.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.account_balance_wallet_outlined,
                      color: AppColors.honeydew,
                      size: 24.0,
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      'Minha Conta',
                      style: AppStyle.p2().withColor(AppColors.honeydew).build(),
                    ),
                  ],
                ),
                onTap: () async {},
              ),
            ),
            const VerticalDivider(
              thickness: 1.0,
              width: 2,
              color: AppColors.deepKoamaru,
            ),
            Container(
              color: AppColors.queenBlue,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(25.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      color: AppColors.honeydew,
                      size: 24.0,
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      'Carrinho',
                      style: AppStyle.p2().withColor(AppColors.honeydew).build(),
                    ),
                  ],
                ),
                onTap: () async {},
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
    return Container(
      margin: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.horizontal(left: Radius.circular(8.0), right: Radius.zero),
      ),
      alignment: Alignment.topLeft,
      width: 250,
      child: StreamBuilder<List<String>>(
          stream: widget._bloc.group,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GroupList(snapshot.data!, (i) {
                //widget._bloc.filterBy(i);
              });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
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
            return const Center(child: CircularProgressIndicator());
            // if (snapshot.hasData) {
            //   return CatalogList(
            //     snapshot.data!,
            //     mockGroup,
            //         (item) {
            //       widget._bloc.delete(item.id);
            //     },
            //         (item) {
            //       widget._bloc.edit(item);
            //     },
            //   );
            // } else {
            //   return const Center(child: CircularProgressIndicator());
            // }
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

class SearchBox extends StatelessWidget {
  final textController = TextEditingController(text: '');

  SearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: AppColors.greyRegular),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: AppColors.backgroundColor,
      ),

      //padding: EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide.none),
          focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide.none),
          hintText: 'Buscar',
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ),
        controller: textController,
        maxLines: 1,
        onSubmitted: (value) {
          textController.clear();
        },
      ),
    );
  }
}
