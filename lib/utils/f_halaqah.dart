import 'package:alhiqniy/main.dart';
import 'package:alhiqniy/models/m_halaqah.dart';
import 'package:alhiqniy/utils/const.dart';
import 'package:alhiqniy/utils/keys.dart';
import 'package:dio/dio.dart' as dio;

import 'f_general.dart';

Future getAllHalaqah() async {
  try {
    dio.Response response = await dio.Dio().get(
      '$url/halaqah',
      options: dio.Options(headers: await getHeader()),
    );

    logger.v(response.data);

    List<Halaqah> list = [];
    response.data['data']
        .forEach((mudaris) => list.add(halaqahFromJson(mudaris)));
    return list;
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
