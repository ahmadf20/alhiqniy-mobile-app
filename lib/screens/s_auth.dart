import 'dart:async';

import 'package:alhiqniy/models/m_user.dart';
import 'package:alhiqniy/providers/p_user.dart';
import 'package:alhiqniy/screens/s_main_menu.dart';
import 'package:alhiqniy/screens/s_verif_mudaris_list.dart';
import 'package:alhiqniy/utils/f_user.dart';
import 'package:alhiqniy/widgets/w_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:alhiqniy/screens/s_choose_mudaris.dart';
import 'package:alhiqniy/screens/s_forgot_password.dart';
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

  TextEditingController signInHandphoneTC = TextEditingController(
      text: '8562207263'); //TODO: should be removed on production
  TextEditingController signInPasswordTC =
      TextEditingController(text: 'thullab');

  TextEditingController signUpHandphoneTC = TextEditingController();
  TextEditingController signUPpasswordTC = TextEditingController();
  TextEditingController signUpNamaTC = TextEditingController();
  TextEditingController signUpUsernameTC = TextEditingController();

  FocusNode signInHandphoneFocus = FocusNode();
  FocusNode signInpasswordFocus = FocusNode();

  FocusNode signUphandphoneFocus = FocusNode();
  FocusNode signUpPasswordFocus = FocusNode();
  FocusNode signUpNamaFocus = FocusNode();
  FocusNode signUpUsernameFocus = FocusNode();

  Widget loginForm() {
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
                  focusNode: signInHandphoneFocus,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller: signInHandphoneTC,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter(RegExp('[\\+1234567890\\ ]'))
                  ],
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(signInpasswordFocus);
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
                  focusNode: signInpasswordFocus,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: signInPasswordTC,
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

  Widget registerForm() {
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
                  focusNode: signUpNamaFocus,
                  style: TextStyle(
                    fontFamily: 'Muli',
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: signUpNamaTC,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(signUpUsernameFocus);
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
                  focusNode: signUpUsernameFocus,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: signUpUsernameTC,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(signUphandphoneFocus);
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
                  focusNode: signUphandphoneFocus,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller: signUpHandphoneTC,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter(RegExp('[\\+0-9\\ ]')),
                  ],
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(signUpPasswordFocus);
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
                  focusNode: signUpPasswordFocus,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: signUPpasswordTC,
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
    signInHandphoneTC.dispose();
    signInPasswordTC.dispose();
    signUpHandphoneTC.dispose();
    signUPpasswordTC.dispose();
    signUpNamaTC.dispose();
    signUpUsernameTC.dispose();
    signInHandphoneFocus.dispose();
    signInpasswordFocus.dispose();
    signUphandphoneFocus.dispose();
    signUpPasswordFocus.dispose();
    signUpNamaFocus.dispose();
    signUpUsernameFocus.dispose();
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
                        MainButton(
                          text: selectedMenu == WidgetMarker.login
                              ? 'LOG IN'
                              : 'REGISTER',
                          image: 'assets/icons/arrow_right.png',
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
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _signInHandleSubmitted() async {
    var handphone = signInHandphoneTC.text.trim();
    var password = signInPasswordTC.text.trim();
    var profile = _userType == 'Thullab' ? '3' : '2';

    setState(() => _isLoading = true);

    print('$handphone, $password, $profile');

    try {
      await signIn(handphone, password, profile).then((response) async {
        if (response is User) {
          await saveLoginData(response.token);
          Provider.of<UserProvider>(context, listen: false).setUser(response);

          print('Token : ${await getToken()}');
          await Navigator.of(context)
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
      signInPasswordTC.clear();
    }
  }

  Future<void> _sighUphandleSubmitted() async {
    var nama = signUpNamaTC.text.trim();
    var username = signUpUsernameTC.text.trim();
    var phone = signUpHandphoneTC.text.trim();
    var password = signUPpasswordTC.text.trim();
    var profile = _userType == 'Thullab' ? '3' : '2';

    setState(() => _isLoading = true);

    print('$phone, $password, $profile, $username, $nama');

    try {
      await signUp(nama, username, phone, password, profile).then((response) {
        if (response is User) {
          saveLoginData(response.token);
          Provider.of<UserProvider>(context, listen: false).setUser(response);

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
      signInPasswordTC.clear();
    }
  }

  void showCustomDialog(String message) {
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
