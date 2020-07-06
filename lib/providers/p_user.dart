import 'package:alhiqniy/main.dart';
import 'package:alhiqniy/models/m_user.dart';
import 'package:alhiqniy/utils/f_user.dart';
import 'package:alhiqniy/widgets/w_custom_bot_toast.dart';
import 'package:flutter/material.dart';

enum UserType { mudaris, thullab }

class UserProvider extends ChangeNotifier {
  User _user;
  UserType _userType;

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  UserType get userType => _userType;
  void setUserType(UserType userType) {
    _userType = userType;
    notifyListeners();
  }

  Future fetchUserData(context) async {
    try {
      await getUserData().then((res) {
        if (res is User) {
          setUser(res);
        } else {
          throw res;
        }
      });
    } catch (e) {
      myBotToastText(e);
      logger.e(e);
    }
  }
}
