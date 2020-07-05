import 'package:alhiqniy/models/prayer_times.dart';
import 'package:flutter/foundation.dart';

class PrayerTimesProvider extends ChangeNotifier {
  PrayerTimes _todayPrayerTimes;

  get todayPrayerTimes => _todayPrayerTimes;

  set(PrayerTimes todayPrayerTimes) {
    _todayPrayerTimes = todayPrayerTimes;
    notifyListeners();
  }
}
