import 'package:alhiqniy/models/m_user.dart';
import 'package:alhiqniy/providers/p_prayer_times.dart';
import 'package:alhiqniy/providers/p_user.dart';
import 'package:alhiqniy/screens/s_landing.dart';
import 'package:alhiqniy/screens/s_main_menu.dart';
import 'package:alhiqniy/utils/const.dart';
import 'package:alhiqniy/utils/f_user.dart';
import 'package:alhiqniy/utils/routes.dart';
import 'package:alhiqniy/widgets/w_custom_bot_toast.dart';
import 'package:alhiqniy/widgets/w_loading_indicator.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
Position currentPosition;

var logger = Logger(
  filter: null,
  printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: true // Should each log print contain a timestamp
      ),
  output: null,
);

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
            primaryColor: Color(0xFF18374C),
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
          home: CheckState(),
          navigatorObservers: [BotToastNavigatorObserver()],
          initialRoute: '/',
          routes: routes,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

class CheckState extends StatefulWidget {
  CheckState({Key key}) : super(key: key);

  @override
  _CheckStateState createState() => _CheckStateState();
}

class _CheckStateState extends State<CheckState> {
  var token;
  bool isLoading = true;

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
      logger.i('token : $value');
      token = value;
      if (value != null) {
        Provider.of<UserProvider>(context, listen: false)
            .fetchUserData(context);
      }
      isLoading = false;
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(child: loadingIndicator()),
          )
        : token == null ? IntroScreen() : MainMenu();
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
