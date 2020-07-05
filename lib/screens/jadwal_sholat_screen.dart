import 'dart:async';

import 'package:alhiqniy/models/prayer_times.dart';
import 'package:alhiqniy/screens/home_screen.dart';
import 'package:alhiqniy/utils/f_prayer_times.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class JadwalSholatScreen extends StatefulWidget {
  static const routeName = '/jadwal_sholat_screen';
  JadwalSholatScreen({Key key}) : super(key: key);

  @override
  _JadwalSholatScreenState createState() => _JadwalSholatScreenState();
}

class _JadwalSholatScreenState extends State<JadwalSholatScreen> {
  CalendarController _calendarController;
  DateTime _focusedDay = DateTime.now();
  Future<PrayerTimes> _fetcthPrayerTimes;
  // bool _isLoading = false;

  updatePrayerTimesData() {
    _fetcthPrayerTimes = fetchPrayerTimes(
        'monthly', 'cimahi', '01-${_focusedDay.month}-${_focusedDay.year}');
  }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    updatePrayerTimesData();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 15,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    BackButton(onPressed: () => Navigator.pop(context)),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Jadwal Sholat',
                        style: TextStyle(
                          fontFamily: 'Muli',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 25,
                  top: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${DateFormat('EEEE', 'id').format(_focusedDay)},',
                      style: TextStyle(
                        fontFamily: 'Muli',
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      DateFormat('d MMMM y', 'id').format(_focusedDay),
                      style: TextStyle(
                        fontFamily: 'Muli',
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Row(
                        children: <Widget>[
                          Spacer(),
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            child: FlatButton(
                              padding: EdgeInsets.all(5),
                              shape: CircleBorder(),
                              child: Icon(
                                Icons.keyboard_arrow_up,
                                size: 35,
                              ),
                              onPressed: () {
                                _calendarController.setSelectedDay(
                                  DateTime(_focusedDay.year,
                                      _focusedDay.month + 1, _focusedDay.day),
                                  runCallback: true,
                                );
                              },
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            child: FlatButton(
                              padding: EdgeInsets.all(5),
                              shape: CircleBorder(),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: 35,
                              ),
                              onPressed: () {
                                _calendarController.setSelectedDay(
                                  DateTime(_focusedDay.year,
                                      _focusedDay.month + 1, _focusedDay.day),
                                  runCallback: true,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(2, 2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: TableCalendar(
                    calendarController: _calendarController,
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
                      ),
                      weekendStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    headerVisible: false,
                    //TODO: prevent user from going to the previous month
                    onDaySelected: (date, list) {
                      if (DateTime.now().month <= date.month &&
                          DateTime.now().year <= date.year) {
                        var tempDate = _focusedDay;

                        setState(() {
                          _focusedDay = date;
                        });
                        print(_focusedDay);

                        if (tempDate.month != date.month) {
                          updatePrayerTimesData();

                          print('update data');
                        }
                      }
                    },
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    builders: CalendarBuilders(
                      dowWeekdayBuilder: (context, string) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 5,
                            ),
                          ),
                          height: 54,
                          child: Center(
                            child: Text(
                              string,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                      todayDayBuilder: (context, date, _) {
                        return Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withAlpha(150),
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          margin: const EdgeInsets.all(10.0),
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
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(4, 4),
                                blurRadius: 7,
                                color: Colors.black26,
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.all(10.0),
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
                      selectedColor: Theme.of(context).primaryColor,
                      holidayStyle: TextStyle(color: Colors.black),
                      weekendStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              //=====[CALENDAR WIDGET]=====

              Padding(
                padding: const EdgeInsets.all(25.0),
                child: FutureBuilder<PrayerTimes>(
                  future: _fetcthPrayerTimes,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data.items.length >= (_focusedDay.day)) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          PrayerTimesCard(
                            title: 'Subuh',
                            image: 'subuh2',
                            time: snapshot.data.items[_focusedDay.day - 1].fajr
                                .toUpperCase(),
                            color: Colors.black,
                          ),
                          PrayerTimesCard(
                            title: 'Syuruq',
                            image: 'syuruq2',
                            time: snapshot
                                .data.items[_focusedDay.day - 1].shurooq
                                .toUpperCase(),
                            color: Colors.black,
                          ),
                          PrayerTimesCard(
                            title: 'Dzuhur',
                            image: 'dzuhur2',
                            time: snapshot.data.items[_focusedDay.day - 1].dhuhr
                                .toUpperCase(),
                            color: Colors.black,
                          ),
                          PrayerTimesCard(
                            title: 'Ashar',
                            image: 'ashar2',
                            time: snapshot.data.items[_focusedDay.day - 1].asr
                                .toUpperCase(),
                            color: Colors.black,
                          ),
                          PrayerTimesCard(
                            title: 'Maghrib',
                            image: 'maghrib2',
                            time: snapshot
                                .data.items[_focusedDay.day - 1].maghrib
                                .toUpperCase(),
                            color: Colors.black,
                          ),
                          PrayerTimesCard(
                            title: 'Isya\'',
                            image: 'isya2',
                            time: snapshot.data.items[_focusedDay.day - 1].isha
                                .toUpperCase(),
                            color: Colors.black,
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    // By default, show a loading spinner.
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
