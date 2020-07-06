import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

void myBotToastText(text) {
  BotToast.showText(
    text: text.toString(),
    textStyle: TextStyle(
      fontFamily: 'OpenSans',
      color: Colors.white,
      fontSize: 12,
    ),
    duration: Duration(seconds: 3),
    borderRadius: BorderRadius.all(Radius.circular(100)),
    clickClose: true,
  );
}
