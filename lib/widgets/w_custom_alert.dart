import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

void showCustomAlert({String text, Color iconColor, IconData icon}) {
  BotToast.showCustomText(
    align: Alignment.center,
    clickClose: true,
    duration: Duration(milliseconds: 750),
    toastBuilder: (_) {
      return Card(
        color: Colors.black38,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: iconColor,
                size: 50,
              ),
              text == null
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 5),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
            ],
          ),
        ),
      );
    },
  );
}
