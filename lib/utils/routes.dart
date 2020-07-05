import 'package:alhiqniy/screens/account_setting.dart';
import 'package:alhiqniy/screens/auth_screen.dart';
import 'package:alhiqniy/screens/chat_screen.dart';
import 'package:alhiqniy/screens/choose_mudaris_screen.dart';
import 'package:alhiqniy/screens/forgot_password_screen.dart';
import 'package:alhiqniy/screens/home_screen.dart';
import 'package:alhiqniy/screens/intro_screen.dart';
import 'package:alhiqniy/screens/jadwal_sholat_screen.dart';
import 'package:alhiqniy/screens/main_menu.dart';
import 'package:alhiqniy/screens/maktabah_screen.dart';
// import 'package:alhiqniy/screens/maktabah_screen.dart';
import 'package:alhiqniy/screens/notification_screen.dart';
import 'package:alhiqniy/screens/presence_screen.dart';
import 'package:alhiqniy/screens/verif_mudaris_list.dart';
import 'package:alhiqniy/screens/verif_mudaris_otp.dart';

final routes = {
  IntroScreen.routeName: (context) => IntroScreen(),
  AuthScreen.routeName: (context) => AuthScreen(),
  ChooseMudaris.routeName: (context) => ChooseMudaris(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  AccountSetting.routeName: (context) => AccountSetting(),
  MainMenu.routeName: (context) => MainMenu(),
  NotificationScreen.routeName: (context) => NotificationScreen(),
  JadwalSholatScreen.routeName: (context) => JadwalSholatScreen(),
  VerifMudarisList.routeName: (context) => VerifMudarisList(),
  VerifMudarisOTP.routeName: (context) => VerifMudarisOTP(),
  ChatScreen.routeName: (context) => ChatScreen(),
  PresenceScreen.routeName: (context) => PresenceScreen(),
  MaktabahScreen.routName: (context) => MaktabahScreen(),
};
