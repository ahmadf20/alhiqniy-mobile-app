import 'package:alhiqniy/models/m_dummy.dart';
import 'package:alhiqniy/providers/p_user.dart';
import 'package:alhiqniy/widgets/w_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notification_screen';
  NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
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
              MyAppBar(title: 'Notifikasi'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    top: 15,
                  ),
                  child: NotifikasiCard(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotifikasiCard extends StatefulWidget {
  NotifikasiCard({Key key}) : super(key: key);

  @override
  _NotifikasiCardState createState() => _NotifikasiCardState();
}

class _NotifikasiCardState extends State<NotifikasiCard> {
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
      padding: EdgeInsets.only(bottom: 22.5),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: ClipOval(
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
              padding: const EdgeInsets.only(left: 16.0, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    listKonfirmasiThullab[index].nama,
                    style: TextStyle(
                      fontFamily: 'Muli',
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.5),
                  Text(
                    'Anda diizinkan mengikuti halaqah Manjahul Haq',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Provider.of<UserProvider>(context).userType == UserType.thullab
              ? Container()
              : listKonfirmasiThullab[index].isAccepted
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
