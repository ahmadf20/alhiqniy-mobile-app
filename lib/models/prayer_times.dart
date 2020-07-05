import 'dart:convert';

PrayerTimes prayerTimesFromJson(String str) =>
    PrayerTimes.fromJson(json.decode(str));

class PrayerTimes {
  String title;
  String query;
  String prayerTimesFor;
  String method;
  String prayerMethodName;
  String daylight;
  String timezone;
  TodayWeather todayWeather;
  String link;
  String qiblaDirection;
  String latitude;
  String longitude;
  String address;
  String city;
  String state;
  String postalCode;
  String country;
  String countryCode;
  List<Item> items;
  int statusValid;
  int statusCode;
  String statusDescription;

  PrayerTimes({
    this.title,
    this.query,
    this.prayerTimesFor,
    this.method,
    this.prayerMethodName,
    this.daylight,
    this.timezone,
    this.todayWeather,
    this.link,
    this.qiblaDirection,
    this.latitude,
    this.longitude,
    this.address,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.countryCode,
    this.items,
    this.statusValid,
    this.statusCode,
    this.statusDescription,
  });

  factory PrayerTimes.fromJson(Map<String, dynamic> json) => PrayerTimes(
        title: json["title"] == null ? null : json["title"],
        query: json["query"] == null ? null : json["query"],
        prayerTimesFor: json["for"] == null ? null : json["for"],
        method: json["method"] == null ? null : json["method"].toString(),
        prayerMethodName: json["prayer_method_name"] == null
            ? null
            : json["prayer_method_name"],
        daylight: json["daylight"] == null ? null : json["daylight"],
        timezone: json["timezone"] == null ? null : json["timezone"],
        todayWeather: json["today_weather"] == null
            ? null
            : TodayWeather.fromJson(json["today_weather"]),
        link: json["link"] == null ? null : json["link"],
        qiblaDirection:
            json["qibla_direction"] == null ? null : json["qibla_direction"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        address: json["address"] == null ? null : json["address"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        postalCode: json["postal_code"] == null ? null : json["postal_code"],
        country: json["country"] == null ? null : json["country"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        statusValid: json["status_valid"] == null ? null : json["status_valid"],
        statusCode: json["status_code"] == null ? null : json["status_code"],
        statusDescription: json["status_description"] == null
            ? null
            : json["status_description"],
      );
}

class Item {
  String dateFor;
  String fajr;
  String shurooq;
  String dhuhr;
  String asr;
  String maghrib;
  String isha;

  Item({
    this.dateFor,
    this.fajr,
    this.shurooq,
    this.dhuhr,
    this.asr,
    this.maghrib,
    this.isha,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        dateFor: json["date_for"] == null ? null : json["date_for"],
        fajr: json["fajr"] == null ? null : convertTimeFormat(json["fajr"]),
        shurooq:
            json["shurooq"] == null ? null : convertTimeFormat(json["shurooq"]),
        dhuhr: json["dhuhr"] == null ? null : convertTimeFormat(json["dhuhr"]),
        asr: json["asr"] == null ? null : convertTimeFormat(json["asr"]),
        maghrib:
            json["maghrib"] == null ? null : convertTimeFormat(json["maghrib"]),
        isha: json["isha"] == null ? null : convertTimeFormat(json["isha"]),
      );
}

class TodayWeather {
  String pressure;
  String temperature;

  TodayWeather({
    this.pressure,
    this.temperature,
  });

  factory TodayWeather.fromJson(Map<String, dynamic> json) => TodayWeather(
        pressure: json["pressure"] == null ? null : json["pressure"].toString(),
        temperature:
            json["temperature"] == null ? null : json["temperature"].toString(),
      );
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => MapEntry(v, k));
    }
    return reverseMap;
  }
}

/// This will convert 12 hours to 24 hours
String convertTimeFormat(String time) {
  int hour, minute;
  String hourString, minuteString;
  var colonIndex = time.indexOf(':');

  hour = int.parse(time.substring(0, time.indexOf(':')));
  hour = time.contains('pm') && hour != 12 ? hour + 12 : hour;
  hourString = (hour < 10) ? '0' + hour.toString() : hour.toString();

  minute = int.parse(time.substring(colonIndex + 1, colonIndex + 3));
  minuteString = (minute < 10) ? '0' + minute.toString() : minute.toString();

  return '$hourString:$minuteString';
}
