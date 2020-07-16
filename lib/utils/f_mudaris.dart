import 'dart:async';
import 'dart:convert';

import 'package:alhiqniy/main.dart';
import 'package:alhiqniy/models/m_mudaris.dart';
import 'package:alhiqniy/utils/const.dart';
import 'package:alhiqniy/utils/f_general.dart';
import 'package:alhiqniy/utils/keys.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart';

Future getAllMudaris() async {
  try {
    dio.Response response = await dio.Dio().get(
      '$url/mudaris',
      options: dio.Options(headers: await getHeader()),
    );

    logger.v(response.data);

    List<Mudaris> mudarisList = [];
    response.data['data']
        .forEach((mudaris) => mudarisList.add(mudarisFromJson(mudaris)));
    return mudarisList;
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
