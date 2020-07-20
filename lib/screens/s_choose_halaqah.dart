import 'dart:async';

import 'package:alhiqniy/main.dart';
import 'package:alhiqniy/models/m_halaqah.dart';
import 'package:alhiqniy/screens/s_dialog.dart';
import 'package:alhiqniy/screens/s_main_menu.dart';
import 'package:alhiqniy/utils/f_halaqah.dart';
import 'package:alhiqniy/widgets/w_app_bar.dart';
import 'package:alhiqniy/widgets/w_button.dart';
import 'package:alhiqniy/widgets/w_loading_indicator.dart';
import 'package:flutter/material.dart';

class ChooseMudaris extends StatefulWidget {
  final bool isEditingMode;
  static const routeName = '/choose_mudaris_screen';

  ChooseMudaris({Key key, this.isEditingMode = false}) : super(key: key);

  @override
  _ChooseMudarisState createState() => _ChooseMudarisState();
}

class _ChooseMudarisState extends State<ChooseMudaris> {
  List<int> listSelectedMudaris = [];

  List<Halaqah> listHalaqah;

  Future fetchHalqahList() async {
    try {
      await getAllHalaqah().then((res) {
        if (res is List<Halaqah>) {
          listHalaqah = res;
          if (mounted) setState(() {});
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchHalqahList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyAppBar(title: 'Pilih:Halaqah'),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 15, 25, 30),
              child: Text(
                'Antum harus memilih Halaqah atau Ustadz untuk mengikuti halaqah di Madrash Online Alhiqniy',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.75,
                ),
              ),
            ),
            Expanded(
              child: listHalaqah == null
                  ? Center(child: loadingIndicator())
                  : MudarisCardList(
                      list: listHalaqah,
                      listSelectedMudaris: listSelectedMudaris,
                      onListChange: (value) {
                        setState(() {
                          listSelectedMudaris = value;
                        });
                      },
                    ),
            ),
            MainButton(
              text: 'KONFIRMASI',
              image: 'assets/icons/arrow_right.png',
              onPressed: listSelectedMudaris.isEmpty
                  ? null
                  : () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DialogScreen(
                            title: 'Sukses!',
                            subtitle:
                                'Antum baru akan terdaftar sebagai thulab di halaqah setelah mendapatkan konfirmasi dari mudaris yang bersangkutan',
                            onConfirm: () => Navigator.of(context)
                                .pushNamedAndRemoveUntil(
                                    MainMenu.routeName, (e) => false),
                          ),
                        ),
                      );
                    },
            ),
          ],
        ),
      ),
    );
  }
}

class MudarisCardList extends StatefulWidget {
  final List<Halaqah> list;
  final Function(List<int>) onListChange;
  final List<int> listSelectedMudaris;

  MudarisCardList(
      {Key key, this.onListChange, this.listSelectedMudaris, this.list})
      : super(key: key);

  @override
  _MudarisCardListState createState() => _MudarisCardListState();
}

class _MudarisCardListState extends State<MudarisCardList> {
  List<int> _listSelectedMudaris;
  List<Halaqah> listHalaqah = [];

  @override
  void initState() {
    super.initState();
    _listSelectedMudaris = widget.listSelectedMudaris;
  }

  @override
  Widget build(BuildContext context) {
    listHalaqah = widget.list;
    return ListView.builder(
      padding: EdgeInsets.only(left: 40),
      itemCount: listHalaqah?.length ?? 0,
      itemBuilder: _buildCardListItem,
      shrinkWrap: true,
    );
  }

  Widget _buildCardListItem(BuildContext context, int index) {
    var item = listHalaqah[index];
    return Ink(
      child: InkWell(
        onTap: () {
          widget.onListChange(_listSelectedMudaris);
          setState(() {
            _listSelectedMudaris.contains(index)
                ? _listSelectedMudaris.remove(index)
                : _listSelectedMudaris.add(index);
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 18.5),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[300],
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _listSelectedMudaris.contains(index)
                  ? Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Center(
                        child: Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Center(
                        child: Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  item.image ?? 'assets/images/profile/profile2.png',
                  width: 56,
                  height: 56,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Text(
                      //   listHalaqah[index].mudaris.name,
                      //   style: TextStyle(
                      //     fontFamily: 'OpenSans',
                      //     color: Colors.black,
                      //     fontSize: 12,
                      //   ),
                      //   maxLines: 2,
                      //   overflow: TextOverflow.ellipsis,
                      // ),
                      Container(
                        padding: const EdgeInsets.only(top: 2.50, right: 10),
                        child: Text(
                          '${item.title}',
                          style: TextStyle(
                            fontFamily: 'Muli',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.50),
                        child: Text(
                          '${item.timeStart}',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
