import 'dart:async';

import 'package:alhiqniy/screens/s_main_menu.dart';
import 'package:alhiqniy/utils/f_mudaris.dart';
import 'package:alhiqniy/utils/function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class VerifMudarisOTP extends StatefulWidget {
  final String idMudaris;
  static const routeName = '/verif_mudaris_OTP';
  VerifMudarisOTP({Key key, this.idMudaris}) : super(key: key);

  @override
  _VerifMudarisOTPState createState() => _VerifMudarisOTPState();
}

class _VerifMudarisOTPState extends State<VerifMudarisOTP> {
  final TextEditingController _pinTC = TextEditingController();

  bool isLoading = false;

  Future onSubmit() async {
    try {
      setState(() => isLoading = true);
      await verifyMudaris(widget.idMudaris, _pinTC.text).then((response) {
        if (response == true) {
          Navigator.of(context).pushNamed(MainMenu.routeName);
        }
      });
    } catch (e) {
      print(e.toString());
      customBotToastText(e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            bottom: 15,
                          ),
                          child: Transform.translate(
                            offset: Offset(-15, 0),
                            child: BackButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Text(
                          'Verifikasi',
                          style: TextStyle(
                            fontFamily: 'Muli',
                            fontSize: 34,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Text(
                          'Mudaris',
                          style: TextStyle(
                            fontFamily: 'Muli',
                            fontSize: 40,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            bottom: 30,
                          ),
                          child: Text(
                            'Antum harus memilih Mudaris atau Ustadz untuk\nmengikuti halaqah di Madrash Online Al-Hiqniy',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: 250,
                          ),
                          child: PinInputTextField(
                            pinLength: 5,
                            decoration: UnderlineDecoration(
                              color: Colors.black,
                              gapSpace: 15,
                              textStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                height: 0.25,
                                fontSize: 50,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatter: <TextInputFormatter>[
                              WhitelistingTextInputFormatter(
                                  RegExp(r'^[0-9]+$'))
                            ],
                            controller: _pinTC,
                            textInputAction: TextInputAction.done,
                            onChanged: (value) {
                              setState(() {
                                // pin = value.toUpperCase();
                              });
                              if (value.length == 8) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }
                            },
                            // onSubmit: (pin) {
                            //   debugPrint('submit pin:$pin');
                            // },
                          ),
                        ),
                      ],
                    ),
                  ),
                  isLoading
                      ? showLoading()
                      : Positioned(
                          bottom: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              height: 47,
                              margin: EdgeInsets.only(
                                bottom: 50,
                                right: 10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'KONFIRMASI',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                  FlatButton(
                                    shape: CircleBorder(),
                                    child: Image.asset(
                                      'assets/icons/next_button.png',
                                      width: 47,
                                    ),
                                    onPressed: _pinTC.text.length < 5
                                        ? null
                                        : onSubmit,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
