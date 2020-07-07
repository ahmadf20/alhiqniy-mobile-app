import 'dart:ui';

import 'package:alhiqniy/providers/p_user.dart';
import 'package:alhiqniy/screens/s_auth.dart';
import 'package:alhiqniy/screens/s_verif_mudaris_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = '/intro_screen';
  IntroScreen({Key key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  UserType selectedUserType = UserType.mudaris;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/welcome.png',
              fit: BoxFit.cover,
              alignment: Alignment.bottomRight,
              color: Colors.black54,
              colorBlendMode: BlendMode.overlay,
              height: double.maxFinite,
              width: double.maxFinite,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Ahlan\nWa Sahlan',
                    style: TextStyle(
                      fontSize: 34,
                      fontFamily: 'OpenSnas',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Text(
                      'Selamat datang di\nmadrasah online Alhiqniy',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'OpenSans',
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 43),
                    child: Text(
                      'MASUK SEBAGAI : ',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'OpenSans',
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 52,
                    margin: EdgeInsets.fromLTRB(25, 15, 25, 0),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      color: Color(0xFF2999B2),
                      onPressed: () {
                        Provider.of<UserProvider>(context, listen: false)
                            .setUserType(UserType.thullab);
                        Navigator.of(context).pushNamed(AuthScreen.routeName);
                      },
                      child: Text(
                        'THULLAB',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Muli',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 52,
                    margin: EdgeInsets.fromLTRB(25, 15, 25, 40),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 8),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          color: Colors.white.withAlpha(20),
                          onPressed: () {
                            Provider.of<UserProvider>(context, listen: false)
                                .setUserType(UserType.mudaris);
                            Navigator.of(context)
                                .pushNamed(VerifMudarisList.routeName);
                          },
                          child: Text(
                            'MUDARIS',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Muli',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
