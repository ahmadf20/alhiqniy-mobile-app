import 'dart:async';
import 'dart:convert';
import 'package:alhiqniy/main.dart';
import 'package:alhiqniy/models/auth.dart';
import 'package:alhiqniy/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> signIn(String phone, String password, String profile) async {
  var body = json.encode({
    "phone": phone.replaceRange(0, phone.indexOf('8'), '62'),
    "password": password,
    "profile": profile
  });

  final response = await post(
    '$url/users/sign-in',
    body: body,
  );

  var responseJson = json.decode(response.body);

  print('${response.body} => ${response.headers} => ${response.statusCode}');

  if (response.statusCode == 200) {
    if (responseJson['status'] == 'ERROR') {
      return responseJson['message'][0];
    } else {
      print('DATA : ${responseJson['data']}');
      return signUpFromJson(responseJson['data']);
    }
  } else if (responseJson['status'] == 'ERROR') {
    return responseJson['message'][0];
  } else {
    return 'Failed to login';
  }
}

Future<dynamic> signUp(String nama, String username, String phone,
    String password, String profile) async {
  var body = json.encode({
    "phone": phone.replaceRange(0, phone.indexOf('8'), '62'),
    "password": password,
    "profile": profile,
    "name": nama,
    "username": username
  });

  print('$phone, $password, $profile, $username, $nama');

  final response = await post(
    '$url/users/sign-up',
    body: body,
  );

  print('${response.body} => ${response.headers} => ${response.statusCode}');

  var responseJson = json.decode(response.body);

// // TODO: update the condition (response) with the proper error message
  if (response.statusCode == 200) {
    if (responseJson['data'] != null) {
      return signUpFromJson(responseJson['data']);
    } else {
      return 'Failed to Sign Up';
    }
  } else {
    return 'Failed to Sign Up';
  }
}

void logOut(BuildContext context) async {
  await clearLoginData();
  await Navigator.of(context)
      .pushNamedAndRemoveUntil(IntroScreen.routeName, (e) => false);
}

Future<void> saveLoginData(
    String handphone, String password, String profile, String token) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setString('handphone', handphone);
  await sharedPreferences.setString('password', password);
  await sharedPreferences.setString('profile', profile);
  await sharedPreferences.setString('token', token);
}

// TODO: implement this!
/// if user (failed to get data) get error message like below which might
/// caused by invalid or expired token then call this function
/// to re-the token code
/// ```{
///     "status": "ERROR",
///     "messages": [
///         "Signature verification failed"
///     ]
/// }```
///

Future<void> updateToken(BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  var handphone = sharedPreferences.getString('handphone');
  var password = sharedPreferences.getString('password');
  var profile = sharedPreferences.getString('profile');

  try {
    await signIn(handphone, password, profile).then((value) async {
      await sharedPreferences.setString('token', value);
      print('Token has been updated!');
    });
  } catch (e) {
    print('Failed to update token : $e');
    logOut(context);
  }
}

Future<String> getToken() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.getString('token');
  return token;
}

Future<void> clearLoginData() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.remove('handphone');
  await sharedPreferences.remove('password');
  await sharedPreferences.remove('profile');
  await sharedPreferences.remove('token');
}
