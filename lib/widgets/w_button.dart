import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text, image;
  final Function onPressed;

  const MainButton({
    Key key,
    @required this.text,
    this.image,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 40, right: 25),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Muli',
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 15),
            CircleAvatar(
              radius: 23,
              backgroundColor: Theme.of(context).primaryColor,
              child: Image.asset(
                image ?? 'assets/icons/done.png',
                height: 15,
                width: 15,
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
    );
  }
}
