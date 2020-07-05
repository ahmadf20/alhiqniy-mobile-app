import 'package:alhiqniy/screens/account_setting.dart';
import 'package:alhiqniy/screens/chat_screen.dart';
import 'package:alhiqniy/screens/home_screen.dart';
import 'package:alhiqniy/screens/notification_screen.dart';
import 'package:flutter/material.dart';

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
        return Container();
        break;
      case 3:
        return NotificationScreen();
        break;
      case 4:
        return AccountSetting();
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
