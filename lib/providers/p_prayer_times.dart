import 'package:alhiqniy/models/m_prayer_times.dart';
import 'package:flutter/foundation.dart';

class PrayerTimesProvider extends ChangeNotifier {
  PrayerTimes _todayPrayerTimes;

  PrayerTimes get todayPrayerTimes => _todayPrayerTimes;

  void set(PrayerTimes todayPrayerTimes) {
    _todayPrayerTimes = todayPrayerTimes;
    notifyListeners();
  }
}
