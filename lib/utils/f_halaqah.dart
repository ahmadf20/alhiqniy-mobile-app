import 'dart:convert';

import 'package:alhiqniy/main.dart';
import 'package:alhiqniy/models/m_halaqah.dart';
import 'package:alhiqniy/utils/const.dart';
import 'package:alhiqniy/utils/keys.dart';
import 'package:dio/dio.dart' as dio;

import 'f_general.dart';

Future getAllHalaqah() async {
  try {
    dio.Response response = await dio.Dio().get(
      '$url/halaqah/search/ ',
      // '$url/halaqah/user/me',
      options: dio.Options(headers: await getHeader()),
    );

    logger.v(response.data);

    return halaqahFromJson(json.encode(response.data['data']));
  } on dio.DioError catch (e) {
    if (e.response != null) throw e.response.data['messages'][0];
    rethrow;
  } catch (e) {
    return ErrorMessage.general;
  }
}
