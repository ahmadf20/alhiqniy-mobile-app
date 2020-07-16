import 'dart:async';
import 'package:alhiqniy/models/m_user.dart';
import 'package:alhiqniy/screens/s_landing.dart';
import 'package:alhiqniy/utils/const.dart';
import 'package:alhiqniy/utils/keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'f_general.dart';

Future<dynamic> signIn(Map data) async {
  try {
    Response response = await Dio().post('$url/users/sign-in',
        data: data, options: Options(headers: await getHeader(false)));

    var responseJson = response.data;

    logger.v(responseJson);

    if (responseJson['status'] == 'ERROR') {
      return responseJson['messages'][0];
    } else {
      responseJson['data']['token'] = responseJson['token'];
      return userFromJson(responseJson['data']);
    }
  } on DioError catch (e) {
    if (e.response != null) {
      return e.response.data['messages'][0];
    } else {
      rethrow;
    }
  } catch (e) {
    return ErrorMessage.general;
  }
}

Future<dynamic> signUp(Map data) async {
  try {
    Response response = await Dio().post('$url/users/sign-up',
        data: data, options: Options(headers: await getHeader(false)));

    var responseJson = response.data;

    logger.v(responseJson);

    if (responseJson['status'] == 'ERROR') {
      return responseJson['messages'][0];
    } else {
      responseJson['data']['token'] = responseJson['token'];
      return userFromJson(responseJson['data']);
    }
  } on DioError catch (e) {
    if (e.response != null) {
      return e.response.data['messages'][0];
    } else {
      rethrow;
    }
  } catch (e) {
    return ErrorMessage.general;
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

  Map data = {
    'handphone': sharedPreferences.getString('handphone'),
    'password': sharedPreferences.getString('password'),
  };

  try {
    await signIn(data).then((value) async {
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
    Response response = await Dio()
        .get('$url/users/me', options: Options(headers: await getHeader()));

    logger.v(response.data);

    return userFromJson(response.data['data']);
  } on DioError catch (e) {
    if (e.response != null) {
      throw e.response.data['messages'][0];
    } else {
      rethrow;
    }
  } catch (e) {
    return ErrorMessage.general;
  }
}

Future<dynamic> updateUserData(Map data) async {
  try {
    Response response = await Dio().put(
      '$url/users/me',
      options: Options(headers: await getHeader()),
      data: data,
    );

    logger.v(response.data);

    return userFromJson(response.data['data']);
  } on DioError catch (e) {
    if (e.response != null) {
      return e.response.data['messages'][0];
    } else {
      rethrow;
    }
  } catch (e) {
    return ErrorMessage.general;
  }
}
