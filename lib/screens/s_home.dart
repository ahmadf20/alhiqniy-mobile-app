import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:alhiqniy/main.dart';
import 'package:alhiqniy/models/m_dummy.dart';
import 'package:alhiqniy/models/m_prayer_times.dart';
import 'package:alhiqniy/providers/p_prayer_times.dart';
import 'package:alhiqniy/providers/p_user.dart';
import 'package:alhiqniy/screens/s_choose_halaqah.dart';
import 'package:alhiqniy/screens/s_detail_halaqah.dart';
import 'package:alhiqniy/screens/s_prayer_times.dart';
import 'package:alhiqniy/screens/s_maktabah.dart';
import 'package:alhiqniy/utils/f_prayer_times.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

UserType _userType;
PrayerTimes _todayPrayerTimes;

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';

  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _currentAddress = 'Jakarta, Indonesia';
  String _nextprayerName = '', _nextPrayerTime = '';

  void getNextPrayerTimes() {
    var currentTime = DateTime.now();

    print(currentTime.toString());
    print(parseToDateTime('12:01').toString());

    if (_todayPrayerTimes != null) {
      if (currentTime
          .isBefore(parseToDateTime(_todayPrayerTimes.items[0].fajr))) {
        _nextprayerName = 'Subuh';
        _nextPrayerTime = _todayPrayerTimes.items[0].fajr.toString();
        print('done');
      } else if (currentTime
          .isBefore(parseToDateTime(_todayPrayerTimes.items[0].shurooq))) {
        _nextprayerName = 'Syuruq';
        _nextPrayerTime = _todayPrayerTimes.items[0].shurooq.toString();
      } else if (currentTime
          .isBefore(parseToDateTime(_todayPrayerTimes.items[0].dhuhr))) {
        _nextprayerName = 'Dzuhur';
        _nextPrayerTime = _todayPrayerTimes.items[0].dhuhr.toString();
      } else if (currentTime
          .isBefore(parseToDateTime(_todayPrayerTimes.items[0].asr))) {
        _nextprayerName = 'Ashar';
        _nextPrayerTime = _todayPrayerTimes.items[0].asr.toString();
      } else if (currentTime
          .isBefore(parseToDateTime(_todayPrayerTimes.items[0].maghrib))) {
        _nextprayerName = 'Maghrib';
        _nextPrayerTime = _todayPrayerTimes.items[0].maghrib.toString();
      } else {
        _nextprayerName = 'Isya\'';
        _nextPrayerTime = _todayPrayerTimes.items[0].isha.toString();
        print('done');
      }
    }
  }

  /// Parse prayer time to DateTime format
  ///  ex: 16:59 => 2020-01-23 16:59:00.000
  DateTime parseToDateTime(String time) {
    return DateTime.tryParse(
        '${DateTime.now().toString().substring(0, 10)} $time');
  }

  void _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);

      Placemark place = p[0];

      if (mounted) {
        setState(() {
          _currentAddress = "${place.locality}, ${place.administrativeArea}";
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _launchYoutube() async {
    if (Platform.isIOS) {
      if (await canLaunch(
          'youtube://www.youtube.com/channel/UCqaStq920t8f3rWzNuOuW5A')) {
        await launch(
            'youtube://www.youtube.com/channel/UCqaStq920t8f3rWzNuOuW5A',
            forceSafariVC: false);
      } else {
        if (await canLaunch(
            'https://www.youtube.com/channel/UCqaStq920t8f3rWzNuOuW5A')) {
          await launch(
              'https://www.youtube.com/channel/UCqaStq920t8f3rWzNuOuW5A');
        } else {
          throw 'Could not launch https://www.youtube.com/channel/UCqaStq920t8f3rWzNuOuW5A';
        }
      }
    } else {
      // Open pdf link which will open pdf reader app (if installed) or web browser
      // const url =
      //     'https://www.alhiqniy.com/wp-content/uploads/2019/10/Fiqhul-Fitan.pdf';
      const url = 'https://www.youtube.com/channel/UCqaStq920t8f3rWzNuOuW5A';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  void _launchWeb() async {
    if (Platform.isIOS) {
      if (await canLaunch('https://www.alhiqniy.com')) {
        await launch('https://www.alhiqniy.com');
      } else {
        throw 'Could not launch https://www.alhiqniy.com';
      }
    } else {
      const url = 'https://www.alhiqniy.com';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  void initState() {
    super.initState();

    if (_todayPrayerTimes == null) {
      fetchPrayerTimesData(); // fetch today's prayer times
    }

    setState(() {
      _userType = Provider.of<UserProvider>(context, listen: false).userType;
    });

    _getAddressFromLatLng();
    // print('LATITUDE: ${currentPosition.latitude.toString()}');
    // print('LONGITUDE: ${currentPosition.longitude.toString()}');

    // print('LATITUDE: ${Provider.of<Location>(context).location}');
  }

  @override
  Widget build(BuildContext context) {
    _todayPrayerTimes =
        Provider.of<PrayerTimesProvider>(context).todayPrayerTimes;
    // getNextPrayerTimes(); //TODO:implement" await befo:re call this function

    print(Provider.of<UserProvider>(context, listen: false).userType);
    print(_nextprayerName);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(ChooseMudaris.routeName),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Color(0xFF3ACCE1),
        child: Icon(Icons.add),
      ),
      body: AnnotatedRegion(
        value: mySystemUIOverlaySyle.copyWith(
            statusBarIconBrightness: Brightness.light),
        child: SafeArea(
          top: false,
          child: ListView(
            padding: EdgeInsets.all(0),
            children: <Widget>[
              Container(
                constraints: BoxConstraints(minHeight: 249),
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      constraints: BoxConstraints(minHeight: 260),
                      child: Image.asset(
                        'assets/images/cover.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 15,
                        top: 40,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 25,
                          ),
                          // (_todayPrayerTimes == null ||
                          //         _todayPrayerTimes.items.length < 0)
                          //     ? Center(child: CircularProgressIndicator())
                          //     : Padding(
                          //         padding: const EdgeInsets.only(bottom: 10.0),
                          //         child: Row(
                          //           children: <Widget>[
                          //             Spacer(),
                          //             PrayerTimesCard(
                          //               title: 'Subuh',
                          //               image: 'subuh',
                          //               time: _todayPrayerTimes.items[0].fajr
                          //                   .toUpperCase(),
                          //             ),
                          //             PrayerTimesCard(
                          //               title: 'Syuruq',
                          //               image: 'syuruq',
                          //               time: _todayPrayerTimes.items[0].shurooq
                          //                   .toUpperCase(),
                          //             ),
                          //             PrayerTimesCard(
                          //               title: 'Dzuhur',
                          //               image: 'dzuhur',
                          //               time: _todayPrayerTimes.items[0].dhuhr
                          //                   .toUpperCase(),
                          //             ),
                          //             PrayerTimesCard(
                          //               title: 'Ashar',
                          //               image: 'subuh',
                          //               time: _todayPrayerTimes.items[0].asr
                          //                   .toUpperCase(),
                          //             ),
                          //             PrayerTimesCard(
                          //               title: 'Maghrib',
                          //               image: 'maghrib',
                          //               time: _todayPrayerTimes.items[0].maghrib
                          //                   .toUpperCase(),
                          //             ),
                          //             PrayerTimesCard(
                          //               title: 'Isya\'',
                          //               image: 'isya',
                          //               time: _todayPrayerTimes.items[0].isha
                          //                   .toUpperCase(),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${DateFormat('EEEE, \nd MMMM y', 'id').format(DateTime.now())}',
                            style: TextStyle(
                              fontFamily: 'Muli',
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            _currentAddress,
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              // fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      child: VerticalDivider(
                        thickness: 1,
                        color: Colors.grey,
                        width: 50,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Waktu $_nextprayerName',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '45.45',
                          // '$_nextPrayerTime',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Theme.of(context).primaryColor,
                            fontSize: 35,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, left: 5),
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.more_vert,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25, bottom: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      CircleCardMenu(
                        icon: 'channel',
                        text: 'Website',
                        onPressed: _launchWeb,
                      ),
                      CircleCardMenu(
                        icon: 'channel',
                        text: 'Channel',
                        onPressed: _launchYoutube,
                      ),
                      CircleCardMenu(
                        icon: 'makhtabah',
                        text: 'Makhtabah',
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(MaktabahScreen.routName);
                        },
                      ),
                      CircleCardMenu(
                        icon: 'alquran',
                        text: 'Al-Qur\'an',
                        onPressed: () {},
                      ),
                      CircleCardMenu(
                        icon: 'kamus',
                        text: 'Kamus',
                        onPressed: () {},
                      ),
                      CircleCardMenu(
                        icon: 'jadwal_sholat',
                        text: 'Jadwal Sholat',
                        onPressed: () => Navigator.of(context)
                            .pushNamed(JadwalSholatScreen.routeName),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                child: Text('Jadwal Halaqah',
                    style: TextStyle(
                      fontFamily: 'Muli',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              CardListHalaqah(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchPrayerTimesData() async {
    try {
      await fetchPrayerTimes(
              'daily', 'cimahi', DateFormat('d-M-y').format(DateTime.now()))
          .then((onValue) {
        print('fetch prayer times data');
        Provider.of<PrayerTimesProvider>(context, listen: false).set(onValue);
        return;
      });
    } catch (e) {
      print(e.toString());
    }
  }
}

class PrayerTimesCard extends StatelessWidget {
  final time, image, title;
  final Color color;
  const PrayerTimesCard(
      {Key key, this.time, this.image, this.title, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Muli',
              color: color ?? Colors.white,
              fontSize: 12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Image.asset(
              'assets/icons/$image.png',
              width: 37,
              height: 37,
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: color ?? Colors.white,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class CircleCardMenu extends StatelessWidget {
  final onPressed, icon, text;

  const CircleCardMenu({Key key, this.onPressed, this.icon, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          FloatingActionButton(
            heroTag: text,
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset('assets/icons/$icon.png'),
            ),
            onPressed: onPressed,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: TextStyle(fontFamily: 'Muli', fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class CardListHalaqah extends StatelessWidget {
  const CardListHalaqah({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: listMudarisDummy.length,
      itemBuilder: _userType == UserType.thullab
          ? _buildCardListItemThullab
          : _buildCardListItemMudaris,
    );
  }

  Widget _buildCardListItemThullab(BuildContext context, int index) {
    return GestureDetector(
      onTap: index == 0
          ? () => Navigator.of(context).pushNamed(DetailHalaqahScreen.routeName)
          : null,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            15, 10, 15, (listMudarisDummy.length - 1) == index ? 40 : 7.5),
        child: Container(
          // height: 92,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: index != 0
                ? null
                : [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
          ),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  boxShadow: index == 0
                      ? null
                      : [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15,
                            offset: Offset(5, 9),
                          ),
                        ],
                ),
                child: Image.asset(
                  'assets/images/list1.png',
                  scale: index == 0 ? 3 : 5,
                  // height:
                  //     MediaQuery.of(context).size.width / (index == 0 ? 3 : 5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 22,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      listMudarisDummy[index].nama,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 2.5),
                    Text(
                      listMudarisDummy[index].halaqah,
                      style: TextStyle(
                        fontFamily: 'Muli',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    index == 0
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/icons/live.png',
                                  height: 25,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Live Sekarang',
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 12,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(
                            '10 Januari 2020 | 10:00 WIB',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardListItemMudaris(BuildContext context, int index) {
    return GestureDetector(
      onTap: index == 0
          ? () => Navigator.of(context).pushNamed(DetailHalaqahScreen.routeName)
          : null,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            15, 10, 15, (listMudarisDummy.length - 1) == index ? 40 : 7.5),
        child: Container(
          // height: 92,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: index != 0
                ? null
                : [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
          ),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  boxShadow: index == 0
                      ? null
                      : [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15,
                            offset: Offset(5, 9),
                          ),
                        ],
                ),
                child: Image.asset(
                  'assets/images/list1.png',
                  scale: index == 0 ? 3 : 5,
                  // height:
                  //     MediaQuery.of(context).size.width / (index == 0 ? 3 : 5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 22,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      listMudarisDummy[index].nama,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 2.5),
                    Text(
                      listMudarisDummy[index].halaqah,
                      style: TextStyle(
                        fontFamily: 'Muli',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    index == 0
                        ? Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/icons/live.png',
                                  height: 25,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Live Sekarang',
                                  style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontSize: 12,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(
                            '10 Januari 2020 | 10:00 WIB',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
