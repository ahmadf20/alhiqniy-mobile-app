import 'package:alhiqniy/utils/f_user.dart';
import 'package:flutter/material.dart';

class AccountSetting extends StatefulWidget {
  static const routeName = '/account_setting';
  AccountSetting({Key key}) : super(key: key);

  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  final FocusNode _namaFocus = FocusNode();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _handphoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool isPassShown = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  top: 8,
                ),
                child: BackButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 25,
                  top: 10,
                ),
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Pengaturan',
                          style: TextStyle(
                            fontSize: 36,
                            fontFamily: 'Muli',
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Text(
                          'Akun',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Muli',
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      child: FlatButton(
                        shape: CircleBorder(),
                        child: Image.asset(
                          'assets/icons/logout.png',
                          width: 47,
                        ),
                        onPressed: () {
                          logOut(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, top: 5),
                padding: EdgeInsets.all(6),
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Colors.grey[300],
                  ),
                ),
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/profile/profile1.png',
                      width: 108,
                      height: 108,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 80,
                        top: 20,
                      ),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Nama Lengkap',
                            ),
                            focusNode: _namaFocus,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_usernameFocus);
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Username',
                            ),
                            focusNode: _usernameFocus,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_handphoneFocus);
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Handphone',
                            ),
                            focusNode: _handphoneFocus,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocus);
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: FlatButton(
                                shape: CircleBorder(),
                                child: Image.asset(
                                  isPassShown
                                      ? 'assets/icons/show_password_true.png'
                                      : 'assets/icons/show_password_false.png',
                                  height: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPassShown = !isPassShown;
                                  });
                                },
                              ),
                            ),
                            focusNode: _passwordFocus,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            obscureText: isPassShown ? false : true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 65,
              ),
              Container(
                height: 47,
                margin: EdgeInsets.only(
                  bottom: 50,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'PERBARUI',
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
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
