import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final Function onPressed;
  final String title;

  const MyAppBar({Key key, this.onPressed, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 10),
            child: BackButton(
              onPressed: onPressed ?? () => Navigator.of(context).maybePop(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              title.replaceAll(':', '\n'),
              style: TextStyle(
                fontSize: 36,
                fontFamily: 'Muli',
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
