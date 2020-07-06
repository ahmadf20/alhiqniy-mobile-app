import 'dart:async';
import 'dart:convert';
import 'package:alhiqniy/models/m_user.dart';
import 'package:alhiqniy/screens/s_landing.dart';
import 'package:alhiqniy/utils/const.dart';
import 'package:alhiqniy/utils/keys.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

Future getHeader([bool hasToken = true]) async {
  Map<String, dynamic> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  if (hasToken) header['Authorization'] = 'Bearer ${await getToken()}';
  return header;
}

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

  logger.v(responseJson);

  if (response.statusCode == 200) {
    if (responseJson['status'] == 'ERROR') {
      return responseJson['message'][0];
    } else {
      return userFromJson(responseJson['data']);
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

  final response = await post(
    '$url/users/sign-up',
    body: body,
  );

  var responseJson = json.decode(response.body);
  logger.d(responseJson);

  //TODO: update the condition (response) with the proper error message
  if (response.statusCode == 200) {
    if (responseJson['data'] != null) {
      return userFromJson(responseJson['data']);
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

Future<void> saveLoginData(String token) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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
  await sharedPreferences.clear();
}

Future getUserData() async {
  try {
    dio.Response response = await dio.Dio()
        .get('$url/users/me', options: dio.Options(headers: await getHeader()));

    logger.v(response.data);

    return userFromJson(response.data['data']);
  } on dio.DioError catch (e) {
    if (e.response != null) {
      throw e.response.data['messages'][0];
    } else {
      rethrow;
    }
  } catch (e) {
    logger.e(e);
    throw ErrorMessage.general;
  }
}

Future<dynamic> updateUserData(Map data) async {
  try {
    dio.Response response = await dio.Dio().put(
      '$url/users/me',
      options: dio.Options(headers: await getHeader()),
      data: data,
    );

    logger.v(response.data);

    return userFromJson(response.data['data']);
  } on dio.DioError catch (e) {
    if (e.response != null) {
      throw e.response.data['messages'][0];
    } else {
      rethrow;
    }
  } catch (e) {
    logger.e(e);
    throw ErrorMessage.general;
  }
}
