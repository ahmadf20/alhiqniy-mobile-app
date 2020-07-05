import 'package:alhiqniy/models/models.dart';
import 'package:alhiqniy/providers/p_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notification_screen';
  NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  UserType _userType;

  @override
  void initState() {
    super.initState();
    setState(() {
      _userType = Provider.of<UserProvider>(context, listen: false).userType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  top: 8,
                ),
                child: BackButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 25,
                  top: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Notifikasi',
                      style: TextStyle(
                        fontSize: 36,
                        fontFamily: 'Muli',
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.symmetric(horizontal: 25),
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(4, 4),
                    )
                  ],
                ),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(22),
                      topRight: Radius.circular(22),
                    ),
                  ),
                  child: Text(
                    _userType == UserType.mudaris
                        ? 'Konfirmasi Thullab'
                        : 'Konfirmasi Halaqah',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  padding: EdgeInsets.only(
                    left: 0,
                  ),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    top: 15,
                  ),
                  child: _userType == UserType.mudaris
                      ? NotifikasiCardMudaris()
                      : NotifikasiCardThullab(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotifikasiCardMudaris extends StatefulWidget {
  NotifikasiCardMudaris({Key key}) : super(key: key);

  @override
  _NotifikasiCardMudarisState createState() => _NotifikasiCardMudarisState();
}

class _NotifikasiCardMudarisState extends State<NotifikasiCardMudaris> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listKonfirmasiThullab.length,
      itemBuilder: _buildCardListItem,
      shrinkWrap: true,
    );
  }

  Widget _buildCardListItem(BuildContext context, int index) {
    return Container(
      height: 75,
      margin: EdgeInsets.only(
          top: 20,
          bottom: (listKonfirmasiThullab.length - 1) == index ? 50 : 0),
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
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                listKonfirmasiThullab[index].gambar,
                width: 56,
                height: 56,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    listKonfirmasiThullab[index].nama,
                    style: TextStyle(
                      fontFamily: 'Muli',
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Meminta Izin untuk mengikuti halaqah',
                    style: TextStyle(
                      fontFamily: 'Muli',
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          listKonfirmasiThullab[index].isAccepted
              ? Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Center(
                    child: Ink(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 90,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            'Hapus Izin',
                            style: TextStyle(
                              fontFamily: 'Muli',
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Center(
                    child: Ink(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 90,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          child: Text(
                            'izinkan',
                            style: TextStyle(
                              fontFamily: 'Muli',
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class NotifikasiCardThullab extends StatefulWidget {
  NotifikasiCardThullab({Key key}) : super(key: key);

  @override
  _NotifikasiCardThullabState createState() => _NotifikasiCardThullabState();
}

class _NotifikasiCardThullabState extends State<NotifikasiCardThullab> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: _buildCardListItem,
      shrinkWrap: true,
    );
  }

  Widget _buildCardListItem(BuildContext context, int index) {
    return Container(
      height: 75,
      margin: EdgeInsets.only(
          top: 20,
          bottom: (listKonfirmasiThullab.length - 1) == index ? 50 : 0),
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
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                listKonfirmasiThullab[index].gambar,
                width: 56,
                height: 56,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    listKonfirmasiThullab[index].nama,
                    style: TextStyle(
                      fontFamily: 'Muli',
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Mengizinkan Antum untuk mengikuti halaqah',
                    style: TextStyle(
                      fontFamily: 'Muli',
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
