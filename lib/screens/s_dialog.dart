import 'package:alhiqniy/widgets/w_app_bar.dart';
import 'package:alhiqniy/widgets/w_button.dart';
import 'package:flutter/material.dart';

class DialogScreen extends StatelessWidget {
  final String title, subtitle, button;
  final Function onConfirm, onBack;

  static const routeName = '/dialog_screen';
  const DialogScreen({
    Key key,
    this.title,
    this.subtitle,
    this.button,
    this.onConfirm,
    this.onBack,  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyAppBar(
              title: '',
              onPressed: onBack ?? () => Navigator.of(context).pop(),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 55),
              child: Text(
                '${title}',
                style: TextStyle(
                  fontFamily: 'Muli',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 55, top: 10),
              width: MediaQuery.of(context).size.width * 3 / 4,
              child: Text(
                '${subtitle}',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.75,
                ),
              ),
            ),
            Spacer(),
            MainButton(
              text: 'Oke',
              image: 'assets/icons/arrow_right.png',
              onPressed: onConfirm ?? () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
