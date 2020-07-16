import 'package:alhiqniy/utils/f_user.dart';

Future getHeader([bool hasToken = true]) async {
  Map<String, dynamic> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  if (hasToken) header['Authorization'] = 'Bearer ${await getToken()}';
  return header;
}
