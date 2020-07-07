import 'package:alhiqniy/providers/p_user.dart';
import 'package:alhiqniy/screens/s_account_setting.dart';
import 'package:alhiqniy/screens/s_announcement.dart';
import 'package:alhiqniy/screens/s_chat.dart';
import 'package:alhiqniy/screens/s_home.dart';
import 'package:alhiqniy/screens/s_notification.dart';
import 'package:alhiqniy/widgets/w_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatefulWidget {
  static const routeName = '/main_menu';
  MainMenu({Key key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  var _selectedIndex = 0;
  Widget callPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return HomeScreen();
        break;
      case 1:
        return ChatScreen();
        break;
      case 2:
        return AnnouncementScreen();
        break;
      case 3:
        return NotificationScreen();
        break;
      case 4:
        var provider = Provider.of<UserProvider>(context);
        if (provider.user == null) provider.fetchUserData(context);
        return provider.user == null
            ? Scaffold(
                body: Center(
                  child: loadingIndicator(),
                ),
              )
            : AccountSetting();
        break;
      default:
        return HomeScreen();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: callPage(_selectedIndex),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25,
        backgroundColor: Colors.white,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/menu_home.png',
              height: 32,
            ),
            activeIcon: Image.asset(
              'assets/icons/menu_home.png',
              height: 32,
              color: Theme.of(context).primaryColor,
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/menu_chat.png',
              height: 32,
            ),
            activeIcon: Image.asset(
              'assets/icons/menu_chat.png',
              height: 32,
              color: Theme.of(context).primaryColor,
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/menu_news.png',
              height: 32,
            ),
            activeIcon: Image.asset(
              'assets/icons/menu_news.png',
              height: 32,
              color: Theme.of(context).primaryColor,
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/menu_notif.png',
              height: 32,
            ),
            activeIcon: Image.asset(
              'assets/icons/menu_notif.png',
              height: 32,
              color: Theme.of(context).primaryColor,
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/menu_profile.png',
              height: 32,
            ),
            activeIcon: Image.asset(
              'assets/icons/menu_profile.png',
              height: 32,
              color: Theme.of(context).primaryColor,
            ),
            title: Container(),
          ),
        ],
      ),
    );
  }
}
