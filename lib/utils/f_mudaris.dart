import 'dart:async';
import 'dart:convert';

import 'package:alhiqniy/main.dart';
import 'package:alhiqniy/models/mudaris.dart';
import 'package:alhiqniy/utils/f_user.dart';
import 'package:http/http.dart';

Future getAllMudaris() async {
  try {
    //TODO: uncomment line below
    // var token =
    // 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1OTY0OTM0MTksImlzcyI6Im1hZHJhc2FoLW9ubGluZSIsInN1YiI6IjI5IiwidXNlcm5hbWUiOiJ0aHVsbGFiMyIsInJvbGUiOiIzIiwiaWF0IjoxNTkzOTAxNDE5fQ._eVFRWtVpoIU6VGeNq6lZPeuoqMULierpfrWbR1Blw8';
    var token = await getToken();

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await get('$url/mudaris', headers: header);

    var responseJson = json.decode(response.body);

    print(
        ' ==================== \n${response.body} => ${response.headers} => ${response.statusCode} \n====================');

    if (responseJson['status'] != 'ERROR') {
      List<Mudaris> mudarisList = [];
      //TODO: should be changed in BE with status OK
      responseJson['data']
          .forEach((mudaris) => mudarisList.add(mudarisFromJson(mudaris)));
      return mudarisList;
    } else if (responseJson['status'] == 'ERROR') {
      throw responseJson['messages'][0];
    } else {
      print('failed to fetch data');
      throw 'Failed to fetch data';
    }
  } catch (e) {
    print(e);
    rethrow;
  }
}

Future verifyMudaris(String mudarisId, String otp) async {
  try {
    //TODO: uncomment line below
    // var token =
    //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1ODc2NDQ2MDksImlzcyI6Im1hZHJhc2FoLW9ubGluZSIsInN1YiI6IjI0IiwidXNlcm5hbWUiOiJ0aHVsbGFiMSIsInJvbGUiOiIzIiwiaWF0IjoxNTg1MDUyNjA5fQ.Yxh43ItgISPW8Y4v1KNzStlmmNcidh6iewOoja61gto';
    var token = await getToken();

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Map _data = {
      "mudaris": mudarisId,
      "otp": otp,
    };

    var body = json.encode(_data);

    final response =
        await post('$url/mudaris/verify', headers: header, body: body);

    var responseJson = json.decode(response.body);

    print(
        ' ==================== \n${response.body} => ${response.headers} => ${response.statusCode} \n====================');

    if (responseJson['status'] == 'OK') {
      return true;
    } else if (responseJson['status'] == 'ERROR') {
      throw responseJson['messages'][0];
    } else {
      print('Error has occured');
      throw 'Error has occured';
    }
  } catch (e) {
    print(e);
    rethrow;
  }
}
