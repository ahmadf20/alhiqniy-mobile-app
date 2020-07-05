import 'dart:async';

import 'package:alhiqniy/models/auth.dart';
import 'package:alhiqniy/providers/p_user.dart';
import 'package:alhiqniy/screens/main_menu.dart';
import 'package:alhiqniy/screens/verif_mudaris_list.dart';
import 'package:alhiqniy/utils/f_user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:alhiqniy/screens/choose_mudaris_screen.dart';
import 'package:alhiqniy/screens/forgot_password_screen.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

enum WidgetMarker { login, register }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth_screen';

  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  WidgetMarker selectedMenu = WidgetMarker.login;
  bool isPassShown = false;
  bool _isLoading = false;
  String _userType;

  TextEditingController _signInHandphoneTC = TextEditingController(
      text: '8562207263'); //TODO: should be removed on production
  TextEditingController _signInPasswordTC =
      TextEditingController(text: 'thullab');

  TextEditingController _signUpHandphoneTC = TextEditingController();
  TextEditingController _signUPpasswordTC = TextEditingController();
  TextEditingController _signUpNamaTC = TextEditingController();
  TextEditingController _signUpUsernameTC = TextEditingController();

  FocusNode _signInHandphoneFocus = FocusNode();
  FocusNode _signInpasswordFocus = FocusNode();

  FocusNode _signUphandphoneFocus = FocusNode();
  FocusNode _signUpPasswordFocus = FocusNode();
  FocusNode _signUpNamaFocus = FocusNode();
  FocusNode _signUpUsernameFocus = FocusNode();

  loginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Form(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 60,
              top: 40,
            ),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Handphone',
                    prefix: Text('+62 '),
                  ),
                  style: TextStyle(
                    fontFamily: 'Muli',
                    fontSize: 18,
                  ),
                  focusNode: _signInHandphoneFocus,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller: _signInHandphoneTC,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter(RegExp('[\\+1234567890\\ ]'))
                  ],
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_signInpasswordFocus);
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
                  style: TextStyle(
                    fontFamily: 'Muli',
                    fontSize: 18,
                  ),
                  focusNode: _signInpasswordFocus,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: _signInPasswordTC,
                  obscureText: isPassShown ? false : true,
                ),
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  margin: EdgeInsets.only(top: 10),
                  child: GestureDetector(
                    child: Text(
                      'Lupa Password?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Muli',
                        color: Theme.of(context).primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ForgotPasswordScreen.routeName);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height - 600,
        // ),
      ],
    );
  }

  registerForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Form(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 60,
              top: 40,
            ),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                  ),
                  focusNode: _signUpNamaFocus,
                  style: TextStyle(
                    fontFamily: 'Muli',
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: _signUpNamaTC,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_signUpUsernameFocus);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  style: TextStyle(
                    fontFamily: 'Muli',
                    fontSize: 18,
                  ),
                  focusNode: _signUpUsernameFocus,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: _signUpUsernameTC,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_signUphandphoneFocus);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Handphone',
                    prefix: Text('+62 '),
                  ),
                  style: TextStyle(
                    fontFamily: 'Muli',
                    fontSize: 18,
                  ),
                  focusNode: _signUphandphoneFocus,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller: _signUpHandphoneTC,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter(RegExp('[\\+0-9\\ ]')),
                  ],
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_signUpPasswordFocus);
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
                  style: TextStyle(
                    fontFamily: 'Muli',
                    fontSize: 18,
                  ),
                  focusNode: _signUpPasswordFocus,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: _signUPpasswordTC,
                  obscureText: isPassShown ? false : true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _userType = (Provider.of<UserProvider>(context, listen: false).userType ==
              UserType.thullab)
          ? 'Thullab'
          : 'Mudaris';
    });
  }

  @override
  void dispose() {
    super.dispose();
    _signInHandphoneTC.dispose();
    _signInPasswordTC.dispose();
    _signUpHandphoneTC.dispose();
    _signUPpasswordTC.dispose();
    _signUpNamaTC.dispose();
    _signUpUsernameTC.dispose();
    _signInHandphoneFocus.dispose();
    _signInpasswordFocus.dispose();
    _signUphandphoneFocus.dispose();
    _signUpPasswordFocus.dispose();
    _signUpNamaFocus.dispose();
    _signUpUsernameFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    MediaQuery.of(context).viewInsets.bottom != 0
                        ? Container()
                        : Image.asset(
                            'assets/images/ornament1.png',
                            alignment: Alignment.bottomCenter,
                          ),
                    ListView(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 15, top: 25),
                          child: BackButton(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 60, top: 10, bottom: 10),
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 50,
                            width: 50,
                            alignment: Alignment.topLeft,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 60),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: 'Muli'),
                              children: <TextSpan>[
                                TextSpan(
                                  text: _userType,
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 60),
                          child: Row(
                            children: <Widget>[
                              ButtonMenu(
                                text: 'Log In',
                                index: WidgetMarker.login,
                                currentIndex: selectedMenu,
                                onPressed: () {
                                  setState(() {
                                    selectedMenu = WidgetMarker.login;
                                    FocusScope.of(context).unfocus();
                                  });
                                },
                              ),
                              ButtonMenu(
                                text: 'Register',
                                index: WidgetMarker.register,
                                currentIndex: selectedMenu,
                                onPressed: () {
                                  setState(() {
                                    selectedMenu = WidgetMarker.register;
                                    FocusScope.of(context).unfocus();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        AnimatedCrossFade(
                          crossFadeState: selectedMenu == WidgetMarker.login
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          duration: Duration(milliseconds: 250),
                          firstChild: loginForm(),
                          secondChild: registerForm(),
                          firstCurve: Curves.easeInOut,
                        ),
                        SizedBox(
                          height: 75,
                        ),
                        Container(
                          height: 47,
                          margin: EdgeInsets.only(
                            bottom: 100,
                            right: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                selectedMenu == WidgetMarker.login
                                    ? 'LOG IN'
                                    : 'REGISTER',
                                style: TextStyle(
                                  fontFamily: 'Muli',
                                  fontWeight: FontWeight.bold,
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
                                onPressed: () {
                                  if (selectedMenu == WidgetMarker.login) {
                                    _signInHandleSubmitted();
                                  } else {
                                    _sighUphandleSubmitted();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _signInHandleSubmitted() async {
    var handphone = _signInHandphoneTC.text.trim();
    var password = _signInPasswordTC.text.trim();
    var profile = _userType == 'Thullab' ? '3' : '2';

    setState(() => _isLoading = true);

    print('$handphone, $password, $profile');

    try {
      await signIn(handphone, password, profile).then((response) {
        if (response is Auth) {
          saveLoginData(handphone, password, profile, response.token);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(MainMenu.routeName, (e) => false);
          print('${response.username} successfully logged in');
        } else {
          showCustomDialog(response);
        }
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() => _isLoading = false);
      _signInPasswordTC.clear();
    }
  }

  Future<void> _sighUphandleSubmitted() async {
    var nama = _signUpNamaTC.text.trim();
    var username = _signUpUsernameTC.text.trim();
    var phone = _signUpHandphoneTC.text.trim();
    var password = _signUPpasswordTC.text.trim();
    var profile = _userType == 'Thullab' ? '3' : '2';

    setState(() => _isLoading = true);

    print('$phone, $password, $profile, $username, $nama');

    try {
      await signUp(nama, username, phone, password, profile).then((response) {
        if (response is Auth) {
          saveLoginData(phone, password, profile, response.token);

          // TODO: make it to be able to go back to the auth_screen, check the user id if it has already registered. Then show choose_mudaris screen when they first login (check in the database if user has chose any mudaris)

          if (profile == '2') {
            //mudaris
            Navigator.of(context).pushNamedAndRemoveUntil(
                VerifMudarisList.routeName, (e) => false);
          } else {
            //thullab
            Navigator.of(context)
                .pushNamedAndRemoveUntil(ChooseMudaris.routeName, (e) => false);
          }

          print('${response.username} successfully singed up!');
        } else {
          showCustomDialog(response);
        }
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() => _isLoading = false);
      _signInPasswordTC.clear();
    }
  }

  showCustomDialog(String message) {
    showDialog(
      context: context,
      child: AlertDialog(
        content: Container(
          constraints: BoxConstraints(
            maxWidth: 100,
            maxHeight: 150,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.close,
                color: Colors.red,
                size: 75,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '$message',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Muli',
                ),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        actions: <Widget>[
          Container(
            width: double.maxFinite,
            child: FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          )
        ],
      ),
    );
  }
}

class ButtonMenu extends StatelessWidget {
  final index;
  final text;
  final currentIndex;
  final onPressed;
  const ButtonMenu(
      {Key key,
      this.index,
      @required this.text,
      this.currentIndex,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, right: 15),
      child: GestureDetector(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontWeight:
                    index == currentIndex ? FontWeight.w700 : FontWeight.w500,
                fontSize: 18,
                color: index == currentIndex
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                fontFamily: 'Muli',
              ),
            ),
            Container(
              width: 20,
              height: 20,
              child: index != currentIndex
                  ? Container()
                  : Divider(
                      color: Theme.of(context).primaryColor,
                      thickness: 2,
                    ),
            ),
          ],
        ),
        onTap: onPressed,
      ),
    );
  }
}
