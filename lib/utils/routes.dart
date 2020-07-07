import 'package:alhiqniy/screens/s_account_setting.dart';
import 'package:alhiqniy/screens/s_announcement.dart';
import 'package:alhiqniy/screens/s_auth.dart';
import 'package:alhiqniy/screens/s_chat.dart';
import 'package:alhiqniy/screens/s_choose_halaqah.dart';
import 'package:alhiqniy/screens/s_detail_halaqah.dart';
import 'package:alhiqniy/screens/s_dialog.dart';
import 'package:alhiqniy/screens/s_forgot_password.dart';
import 'package:alhiqniy/screens/s_home.dart';
import 'package:alhiqniy/screens/s_landing.dart';
import 'package:alhiqniy/screens/s_prayer_times.dart';
import 'package:alhiqniy/screens/s_main_menu.dart';
import 'package:alhiqniy/screens/s_maktabah.dart';
import 'package:alhiqniy/screens/s_notification.dart';
import 'package:alhiqniy/screens/s_presence.dart';
import 'package:alhiqniy/screens/s_verif_mudaris_list.dart';
import 'package:alhiqniy/screens/s_verif_mudaris_otp.dart';

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
  DetailHalaqahScreen.routeName: (context) => DetailHalaqahScreen(),
  DialogScreen.routeName: (context) => DialogScreen(),
  AnnouncementScreen.routeName: (context) => AnnouncementScreen(),
};
