import 'package:flutter/material.dart';

enum UserType { mudaris, thullab }

class UserProvider extends ChangeNotifier {
  UserType _userType;

  get userType => _userType;
  set(UserType userType) {
    this._userType = userType;
    notifyListeners();
  }
}
