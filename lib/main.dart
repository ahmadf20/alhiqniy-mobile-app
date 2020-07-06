import 'package:alhiqniy/providers/p_prayer_times.dart';
import 'package:alhiqniy/providers/p_user.dart';
import 'package:alhiqniy/screens/s_landing.dart';
import 'package:alhiqniy/screens/s_main_menu.dart';
import 'package:alhiqniy/utils/f_user.dart';
import 'package:alhiqniy/utils/routes.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
Position currentPosition;
void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

SystemUiOverlayStyle mySystemUIOverlaySyle = SystemUiOverlayStyle(
  systemNavigationBarColor: Colors.white,
  systemNavigationBarIconBrightness: Brightness.dark,
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.dark,
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var token;

  void getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        currentPosition = position;
      });
      print(currentPosition.latitude.toString());
    }).catchError((e) {
      print(e.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation(); //fetch current location
    getToken().then((value) {
      print('token : $value');
      setState(() {
        token = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return AnnotatedRegion(
      value: mySystemUIOverlaySyle,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider(),
          ),
          ChangeNotifierProvider<PrayerTimesProvider>(
            create: (_) => PrayerTimesProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Madrasah Online Al Hiqniy',
          theme: ThemeData(
            primaryColor: Color(0xFF063C65),
            // textTheme: TextTheme(
            //   title: TextStyle(
            //     fontFamily: 'Muli',
            //   ),
            //   bodyText1: TextStyle(
            //     fontFamily: 'OpenSans',
            //   ),
            // ),
          ),
          builder: (context, child) {
            child = ScrollConfiguration(
              behavior: MyBehavior(),
              child: child,
            );

            child = botToastBuilder(context, child);
            return child;
          },
          // home: IndexPage(),
          home: token == null ? IntroScreen() : MainMenu(),
          navigatorObservers: [BotToastNavigatorObserver()],
          initialRoute: '/',
          routes: routes,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

//remove scroll bound effect
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
