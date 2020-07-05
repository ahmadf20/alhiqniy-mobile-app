import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

Widget showLoading() {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        Color(0xFF063C65),
      ),
    ),
  );
}

void customBotToastText(String text) {
  BotToast.showText(
    text: text,
    textStyle: TextStyle(
      fontFamily: 'OpenSans',
      color: Colors.white,
      fontSize: 12,
    ),
    duration: Duration(seconds: 5),
    borderRadius: BorderRadius.all(Radius.circular(100)),
    clickClose: true,
  );
}
