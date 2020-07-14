import 'dart:async';
import 'dart:io';

import 'package:alhiqniy/providers/p_user.dart';
import 'package:alhiqniy/screens/s_landing.dart';
import 'package:alhiqniy/screens/s_main_menu.dart';
import 'package:alhiqniy/utils/f_user.dart';
import 'package:alhiqniy/utils/routes.dart';
import 'package:alhiqniy/widgets/w_loading_indicator.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
Position currentPosition;

String deviceToken;

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
  final FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;

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

  Future _getDeviceToken() async {
    await _fcm.getToken().then((token) {
      deviceToken = token;
      if (mounted) setState(() {});
      print(('device token: $deviceToken'));
    });
  }

  Future fcmConfigure() async {
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        print(data);
        _getDeviceToken();
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    } else {
      await _getDeviceToken();
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessageee: $message");
        // print(message['data']['body']);
        //TODO: update noitif badged and bottoast
        if (message['notification'] != null) {
          BotToast.showNotification(
            enableSlideOff: true,
            onlyOne: true,
            title: (_) => Text(message['notification']['title']),
            subtitle: (_) => message['notification']['body'] == null
                ? Text('')
                : Text(message['notification']['body']),
            crossPage: true,
            leading: (_) => SizedBox.fromSize(
                size: const Size(40, 40),
                child: ClipOval(
                    child: Icon(
                  Icons.info_outline,
                ))),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  (MaterialPageRoute(builder: (context) {
                    return MainMenu();
                  })),
                  (e) => false);
            },
            duration: Duration(seconds: 2),
            animationDuration: Duration(milliseconds: 200),
            animationReverseDuration: Duration(milliseconds: 200),
          );
          // customBotToastText(message['notification']['body']);
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunchhhh: $message");
        if (message['data']['body'].contains('Permintaan')) {
          print('called');
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MainMenu()));
        }
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResumeeeee: $message");
        if (message['data']['body'].contains('Permintaan')) {
          print('called');
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MainMenu()));
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fcmConfigure();
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
