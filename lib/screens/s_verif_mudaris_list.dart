import 'dart:async';

import 'package:alhiqniy/models/m_mudaris.dart';
import 'package:alhiqniy/screens/s_verif_mudaris_otp.dart';
import 'package:alhiqniy/utils/f_mudaris.dart';
import 'package:alhiqniy/utils/function.dart';
import 'package:alhiqniy/widgets/w_app_bar.dart';
import 'package:flutter/material.dart';

String _selectedMudaris;

class VerifMudarisList extends StatefulWidget {
  static const routeName = '/verif_mudaris_list';
  VerifMudarisList({Key key}) : super(key: key);

  @override
  _VerifMudarisListState createState() => _VerifMudarisListState();
}

class _VerifMudarisListState extends State<VerifMudarisList> {
  List<Mudaris> listMudaris;
  String filter = '';
  TextEditingController searchTC = TextEditingController();

  Future getMudarisList() async {
    try {
      await getAllMudaris().then((response) {
        if (response is List<Mudaris>) {
          listMudaris = response;
          setState(() {});
        }
      });
    } catch (e) {
      print(e.toString());
      customBotToastText(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getMudarisList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MyAppBar(
                title: 'Antum:Mudaris?',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 40),
                  child: Text(
                    'Hanya Mudaris yang terverifikasi oleh Admin yang diizinkan untuk mengajar di Madrasah Online Al-Hiqniy',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 40),
                child: TextField(
                  controller: searchTC,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Cari nama Antum di sini ...',
                    alignLabelWithHint: false,
                    labelStyle: TextStyle(fontFamily: 'Muli'),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (val) {},
                ),
              ),
              Expanded(
                child: listMudaris == null
                    ? showLoading()
                    : MudarisCardList(
                        list: listMudaris,
                        filter: filter,
                      ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 47,
                  margin: EdgeInsets.only(
                    bottom: 50,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'VERIFIKASI',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      FlatButton(
                        shape: CircleBorder(),
                        child: Image.asset(
                          'assets/icons/next_button.png',
                          width: 47,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return VerifMudarisOTP(
                              idMudaris: _selectedMudaris,
                            );
                          }));
                        },
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

class MudarisCardList extends StatefulWidget {
  final List<Mudaris> list;
  final String filter;
  const MudarisCardList({Key key, this.list, this.filter}) : super(key: key);

  @override
  _MudarisCardListState createState() => _MudarisCardListState();
}

class _MudarisCardListState extends State<MudarisCardList> {
  var listMudaris = [];

  @override
  Widget build(BuildContext context) {
    listMudaris = widget.list;
    return ListView.builder(
      itemCount: listMudaris.length,
      itemBuilder: _buildCardListItem,
      shrinkWrap: true,
    );
  }

  Widget _buildCardListItem(BuildContext context, int index) {
    var item = listMudaris[index];
    Widget cardItem = Ink(
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {
            _selectedMudaris = _selectedMudaris == item.id ? null : item.id;
          });
        },
        child: Container(
          height: 65,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[300],
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              item.id == _selectedMudaris
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
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Center(
                  child: Text(
                    item.name,
                    style: TextStyle(
                      fontFamily: 'Muli',
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return widget.filter.isEmpty
        ? cardItem
        : item.name.toLowerCase().contains(widget.filter.toLowerCase())
            ? cardItem
            : Container();
  }
}
