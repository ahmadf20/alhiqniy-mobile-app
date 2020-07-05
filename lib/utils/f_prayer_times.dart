import 'dart:async';

import 'package:alhiqniy/models/prayer_times.dart';
import 'package:http/http.dart';

/// [value, default value, description]
///
/// - [Location]
/// City, country, state...	Auto select for the user	Name of the location where user is at or his state name or his country name or with his latitude and longitude .
///
/// - [Times]
/// Daily, weekly, monthly or yearly	Monthly	Limit the prayer times by the value.
///
/// - [Date]
/// 12-02-2012	Today Date	Get the prayer times for the given date, please make sure the date is further head or current date. Heads up! Previous dates will be deprecated from the api.
///
/// - [Daylight saving]
/// True or false	Auto select	Daylight saving for the user, if true then hours are incremented by 1+
///
/// - [Method]
/// - 1 = Egyptian General Authority of Survey
/// - 2 = University Of Islamic Sciences, Karachi (Shafi)
/// - 3 = University Of Islamic Sciences, Karachi (Hanafi)
/// - 4 = Islamic Circle of North America
/// - 5 = Muslim World League
/// - 6 = Umm Al-Qura
/// - 7 = Fixed Isha	Auto select based on the country where user is from.	Method to use for calculation of the timing. If method is provided invalid based on the country, it will give incorrect timing.
/// ex: https://muslimsalat.com/london/weekly/12-01-2013/true/5.json?key=api_key
///
/// docs: http://muslimsalat.com/api/#key
Future fetchPrayerTimes(String period, String city, String date,
    {String key, String school}) async {
  // var key = '2da46b61f60deee241e078ccd82588b0';

  try {
    final response = await get(
        // 'https://muslimsalat.p.rapidapi.com/$city/$period/$date.json?key=$key');
        'https://muslimsalat.com/$city/$period/$date.json');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return prayerTimesFromJson(response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  } catch (e) {
    print(e);
  }
}

Future<PrayerTimes> fetchPrayerTimesbyLatLong(
    String period, String latitute, String longitude, String date,
    {String key, String school}) async {
  // var key = '2da46b61f60deee241e078ccd82588b0';

  final response = await get(
      // 'https://muslimsalat.p.rapidapi.com/$city/$period/$date.json?key=$key');
      'https://muslimsalat.com/$latitute,$longitude/$period/$date.json');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return prayerTimesFromJson(response.body);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}
//TODO: these
// 1. try to use the geolocation to be used as query
// 2. use another API without deleting the above API https://prayertimes.date/api/docs/month
