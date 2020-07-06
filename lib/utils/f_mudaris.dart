import 'dart:async';
import 'dart:convert';

import 'package:alhiqniy/main.dart';
import 'package:alhiqniy/models/m_mudaris.dart';
import 'package:alhiqniy/utils/const.dart';
import 'package:alhiqniy/utils/keys.dart';
import 'package:alhiqniy/utils/f_user.dart';
import 'package:http/http.dart';

Future getAllMudaris() async {
  try {
    final response = await get('$url/mudaris', headers: await getHeader());

    var responseJson = json.decode(response.body);
    logger.d(responseJson);

    if (responseJson['status'] != 'ERROR') {
      List<Mudaris> mudarisList = [];
      //TODO: should be changed in BE with status OK
      responseJson['data']
          .forEach((mudaris) => mudarisList.add(mudarisFromJson(mudaris)));
      return mudarisList;
    } else if (responseJson['status'] == 'ERROR') {
      throw responseJson['messages'][0];
    } else {
      throw ErrorMessage.general;
    }
  } catch (e) {
    logger.e(e);
    rethrow;
  }
}

Future verifyMudaris(String mudarisId, String otp) async {
  try {
    Map _data = {
      "mudaris": mudarisId,
      "otp": otp,
    };

    var body = json.encode(_data);

    final response = await post('$url/mudaris/verify',
        headers: await getHeader(), body: body);

    var responseJson = json.decode(response.body);
    logger.d(responseJson);

    if (responseJson['status'] == 'OK') {
      return true;
    } else if (responseJson['status'] == 'ERROR') {
      throw responseJson['messages'][0];
    } else {
      throw ErrorMessage.general;
    }
  } catch (e) {
    logger.e(e);
    rethrow;
  }
}
