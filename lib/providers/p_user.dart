import 'package:flutter/material.dart';

enum UserType { mudaris, thullab }

class UserProvider extends ChangeNotifier {
  UserType _userType;

  UserType get userType => _userType;
  void set(UserType userType) {
    _userType = userType;
    notifyListeners();
  }
}
