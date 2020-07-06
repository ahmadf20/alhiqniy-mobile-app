import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot_password';
  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, top: 25, bottom: 10),
              child: BackButton(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: Text(
                'Masukkan\nNomor\nHandphone',
                style: TextStyle(
                  fontFamily: 'Muli',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 60,
                right: 30,
                top: 20,
              ),
              child: Text(
                'Kami akan kirimkan password Antum\nke nomor handphone  yang telah terverifikasi/ndengan akun Antum',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60, top: 40.0),
              child: Form(
                child: TextFormField(
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
