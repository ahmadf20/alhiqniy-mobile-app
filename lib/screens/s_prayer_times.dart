import 'package:adhan/adhan.dart';
import 'package:alhiqniy/main.dart';
import 'package:alhiqniy/providers/p_user.dart';
import 'package:alhiqniy/widgets/w_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class JadwalSholatScreen extends StatefulWidget {
  static const routeName = '/jadwal_sholat_screen';
  JadwalSholatScreen({Key key}) : super(key: key);

  @override
  _JadwalSholatScreenState createState() => _JadwalSholatScreenState();
}

class _JadwalSholatScreenState extends State<JadwalSholatScreen> {
  final CalendarController _calendarController = CalendarController();

  DateTime _focusedDay = DateTime.now();
  PrayerTimes prayerTimes;
  UserProvider userProvider;
  String currentAddress = 'Jakarta, Indonesia';

  @override
  void initState() {
    super.initState();
    getAddressFromLatLng();
  }

  void getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);

      Placemark place = p[0];

      if (mounted) {
        setState(() {
          currentAddress = "${place.locality}, ${place.administrativeArea}";
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void fetchPrayerTimesData(DateTime time) {
    final Coordinates myCoordinate = Coordinates(
        currentPosition?.latitude ?? -6.2,
        currentPosition?.longitude ?? 106.816667);

    final params = CalculationMethod.singapore.getParameters();
    params.madhab = Madhab.shafi;

    DateComponents dateComponents = DateComponents.from(time);

    final PrayerTimes _prayerTimes = PrayerTimes.utcOffset(
        myCoordinate, dateComponents, params, Duration(hours: 7));
    prayerTimes = _prayerTimes;
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var hijriDate = HijriCalendar.fromDate(_focusedDay);
    fetchPrayerTimesData(_focusedDay);

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion(
        value:
            mySystemUIOverlaySyle.copyWith(statusBarColor: Colors.transparent),
        child: SafeArea(
          top: false,
          child: ListView(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 35),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 30,
                      )
                    ]),
                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'assets/images/ornament2.png',
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.bottomRight,
                        width: MediaQuery.of(context).size.width * 4.5 / 8,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 55),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            '${DateFormat('EEEE', 'id_ID').format(_focusedDay) == 'Minggu' ? 'Ahad' : DateFormat('EEEE', 'id_ID').format(_focusedDay)},',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF18374C),
                            ),
                          ),
                          Text(
                            DateFormat('d MMMM y', 'id_ID').format(_focusedDay),
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF18374C),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              '${hijriDate.toFormat("dd MMMM yyyy")}',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF18374C),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              '${currentAddress}',
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(height: 35),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('S'),
                                Text('S'),
                                Text('R'),
                                Text('K'),
                                Text('J'),
                                Text('S'),
                                Text('A'),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              //=====[CALENDAR WIDGET]=====
              Container(
                padding: EdgeInsets.only(
                  bottom: 25,
                  left: 0,
                ),
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: TableCalendar(
                    calendarController: _calendarController,
                    simpleSwipeConfig: null,
                    locale: 'id',
                    availableCalendarFormats: {
                      CalendarFormat.month: 'Months',
                    },
                    availableGestures: AvailableGestures.horizontalSwipe,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      dowTextBuilder: (date, locale) {
                        return DateFormat.E(locale).format(date).toUpperCase();
                      },
                      weekdayStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montsrerat',
                      ),
                      weekendStyle: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montsrerat',
                      ),
                    ),
                    headerVisible: false,
                    onDaySelected: (date, list) {
                      _focusedDay = date;
                      setState(() {});
                      print(_focusedDay);
                    },
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    builders: CalendarBuilders(
                      dowWeekdayBuilder: (context, string) {
                        return Container();
                      },
                      todayDayBuilder: (context, date, _) {
                        return Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withAlpha(150),
                            shape: BoxShape.circle,
                          ),
                          margin: const EdgeInsets.all(5.0),
                          width: 75,
                          height: 75,
                          child: Center(
                            child: Text(
                              '${date.day}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                      selectedDayBuilder: (context, date, _) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF18374C),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 7,
                                color: Colors.black12,
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.all(5.0),
                          width: 75,
                          height: 75,
                          child: Center(
                            child: Text(
                              '${date.day}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    calendarStyle: CalendarStyle(
                      contentPadding: EdgeInsets.all(0),
                      selectedColor: Color(0xFF18374C),
                      holidayStyle: TextStyle(color: Colors.black),
                      weekendStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              //=====[CALENDAR WIDGET]=====
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  'Jadwal Shalat',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF18374C),
                  ),
                ),
              ),
              SizedBox(height: 35),
              prayerTimes == null
                  ? loadingIndicator()
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 25),
                          PrayerTimesCard(
                            title: 'Subuh',
                            image: 'subuh2',
                            time: prayerTimes?.fajr ?? '',
                            color: Colors.black,
                          ),
                          PrayerTimesCard(
                            title: 'Syuruq',
                            image: 'syuruq2',
                            time: prayerTimes?.sunrise ?? '',
                            color: Colors.black,
                          ),
                          PrayerTimesCard(
                            title: 'Dzuhur',
                            image: 'dzuhur2',
                            time: prayerTimes?.dhuhr ?? '',
                            color: Colors.black,
                          ),
                          PrayerTimesCard(
                            title: 'Ashar',
                            image: 'ashar2',
                            time: prayerTimes?.asr ?? '',
                            color: Colors.black,
                          ),
                          PrayerTimesCard(
                            title: 'Maghrib',
                            image: 'maghrib2',
                            time: prayerTimes?.maghrib ?? '',
                            color: Colors.black,
                          ),
                          PrayerTimesCard(
                            title: 'Isya\'',
                            image: 'isya2',
                            time: prayerTimes?.isha ?? '',
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class PrayerTimesCard extends StatelessWidget {
  final String image, title;
  final DateTime time;
  final Color color;
  const PrayerTimesCard(
      {Key key, this.time, this.image, this.title, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 22.5),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: color ?? Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Image.asset(
              'assets/icons/$image.png',
              width: 37,
              height: 37,
            ),
          ),
          Text(
            DateFormat('HH:mm').format(time),
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: color ?? Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
