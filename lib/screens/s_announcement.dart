import 'package:alhiqniy/widgets/w_app_bar.dart';
import 'package:flutter/material.dart';

class AnnouncementScreen extends StatelessWidget {
  static const routeName = '/announcement_screen';
  const AnnouncementScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            MyAppBar(
              title: 'Pengumuman',
            )
          ],
        ),
      ),
    );
  }
}
