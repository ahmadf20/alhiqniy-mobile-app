import 'package:alhiqniy/widgets/w_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot_password';
  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController phoneTC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(top: 5, left: 5),
          children: <Widget>[
            MyAppBar(
              title: 'Masukkan:Nomor:Handphone',
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 30,
                top: 20,
              ),
              child: Text(
                'Kami akan kirimkan password Antum ke nomor handphone  yang telah terverifikasi dengan akun Antum',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.75,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 35),
              child: Form(
                child: TextFormField(
                  controller: phoneTC,
                  style: TextStyle(
                    fontFamily: 'Muli',
                    fontSize: 18,
                  ),
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter(RegExp('[\\0-9\\ ]')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Handphone',
                    prefix: Text('+62 '),
                    suffix: Container(
                      width: 50,
                      height: 25,
                      child: FlatButton(
                        padding: EdgeInsets.all(5),
                        shape: CircleBorder(),
                        child: Icon(Icons.done),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                ),
              ),
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height - 800,
            // ),
          ],
        ),
      ),
    );
  }
}
