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
        return NotificationScreen();
        break;
      case 3:
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
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25,
        elevation: 10,
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
              'assets/icons/home.png',
              height: 20,
            ),
            activeIcon: Image.asset(
              'assets/icons/home1.png',
              height: 20,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                fontFamily: 'OpenSans',
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/chat.png',
              height: 20,
            ),
            activeIcon: Image.asset(
              'assets/icons/chat1.png',
              height: 20,
            ),
            title: Text(
              'Chat',
              style: TextStyle(
                fontFamily: 'OpenSans',
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/notifikasi.png',
              height: 20,
            ),
            activeIcon: Image.asset(
              'assets/icons/notifikasi1.png',
              height: 20,
            ),
            title: Text(
              'Nofitikasi',
              style: TextStyle(
                fontFamily: 'OpenSans',
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/akun.png',
              height: 20,
            ),
            activeIcon: Image.asset(
              'assets/icons/akun1.png',
              height: 20,
            ),
            title: Text(
              'Akun',
              style: TextStyle(
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
