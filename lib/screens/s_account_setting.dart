import 'package:alhiqniy/main.dart';
import 'package:alhiqniy/models/m_user.dart';
import 'package:alhiqniy/providers/p_user.dart';
import 'package:alhiqniy/utils/f_user.dart';
import 'package:alhiqniy/widgets/w_custom_alert.dart';
import 'package:alhiqniy/widgets/w_custom_bot_toast.dart';
import 'package:alhiqniy/widgets/w_app_bar.dart';
import 'package:alhiqniy/widgets/w_button.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountSetting extends StatefulWidget {
  static const routeName = '/account_setting';
  AccountSetting({Key key}) : super(key: key);

  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  bool isPassShown = false;
  bool isEditingPassword = false;

  TextEditingController nameTC;
  TextEditingController usernameTC;
  TextEditingController phoneTC;
  TextEditingController passwordTC;

  TextEditingController newPasswordTC = TextEditingController();
  TextEditingController newPasswordConfirmTC = TextEditingController();

  var formTextStyle = TextStyle(
    fontFamily: 'Muli',
    fontSize: 18,
  );

  void setUserData() async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false).user;

      nameTC = TextEditingController(text: user?.name ?? '');
      usernameTC = TextEditingController(text: user?.username ?? '');
      phoneTC = TextEditingController(text: user?.phone ?? '');
      passwordTC = TextEditingController(text: '');
      if (mounted) setState(() {});
    } catch (e) {
      logger.e(e);
      myBotToastText(e);
    }
  }

  Future<void> updateProfile() async {
    if (passwordTC.text.length < 3) {
      myBotToastText('Password tidak boleh kosong');
      return;
    } else if (nameTC.text.isEmpty ||
        usernameTC.text.isEmpty ||
        phoneTC.text.isEmpty) {
      myBotToastText('Silakan lengkapi data Anda');
      return;
    }

    var data = {
      "name": nameTC.text.trim(),
      "phone":
          phoneTC.text.replaceRange(0, phoneTC.text.indexOf('8'), '62').trim(),
      "username": usernameTC.text.trim(),
      "password": passwordTC.text.trim(),
    };

    // if (newPasswordConfirmTC.text.isNotEmpty &&
    //     newPasswordTC.text.isNotEmpty == newPasswordConfirmTC.text.isNotEmpty) {
    //       data["password"] =
    //     }

    try {
      BotToast.showLoading();
      await updateUserData(data).then((response) {
        if (response is User) {
          showCustomAlert(
            text: 'Berhasil!',
            iconColor: Color(0xFFFFD800),
            icon: Icons.done,
          );
          Provider.of<UserProvider>(context, listen: false).setUser(response);

          setUserData();
        } else {
          throw response;
        }
      });
    } catch (e) {
      logger.e(e);
      myBotToastText(e);
    } finally {
      BotToast.closeAllLoading();
    }
  }

  @override
  void initState() {
    super.initState();
    setUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  MyAppBar(
                    title: isEditingPassword
                        ? 'Ganti:Password'
                        : 'Pengaturan:Akun',
                    onPressed: isEditingPassword
                        ? () {
                            isEditingPassword = false;
                            FocusScope.of(context).unfocus();
                            setState(() {});
                          }
                        : null,
                  ),
                  isEditingPassword
                      ? Container()
                      : Positioned(
                          right: 0,
                          top: 25,
                          child: FlatButton(
                            shape: CircleBorder(),
                            child: Image.asset(
                              'assets/icons/logout.png',
                              width: 47,
                            ),
                            onPressed: () => logOut(context),
                          ),
                        ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            isEditingPassword
                ? buildEditPassword(context)
                : buildEditProfile(context),
            SizedBox(
              height: 65,
            ),
            MainButton(
              text: 'PERBARUI',
              onPressed: updateProfile,
            ),
          ],
        ),
      ),
    );
  }

  Padding buildEditPassword(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 60,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: passwordTC,
            style: formTextStyle,
            decoration: InputDecoration(
              labelText: 'Password Lama',
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
            keyboardType: TextInputType.text,
            obscureText: isPassShown ? false : true,
          ),
          SizedBox(height: 25),
          TextFormField(
            controller: newPasswordTC,
            style: formTextStyle,
            decoration: InputDecoration(
              labelText: 'Password Baru',
            ),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 25),
          TextFormField(
            controller: newPasswordConfirmTC,
            style: formTextStyle,
            decoration: InputDecoration(
              labelText: 'Konfirmasi Password Baru',
              errorText: newPasswordConfirmTC.text == newPasswordTC.text
                  ? null
                  : 'Password tidak cocok',
            ),
            onChanged: (_) {
              setState(() {});
            },
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  Padding buildEditProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 60,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: nameTC,
            style: formTextStyle,
            decoration: InputDecoration(
              labelText: 'Nama',
            ),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 25),
          TextFormField(
            controller: usernameTC,
            style: formTextStyle,
            decoration: InputDecoration(
              labelText: 'Username',
            ),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 25),
          TextFormField(
            controller: phoneTC,
            style: formTextStyle,
            decoration: InputDecoration(
              labelText: 'Handphone',
            ),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 25),
          TextFormField(
            controller: passwordTC,
            style: formTextStyle,
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
            keyboardType: TextInputType.text,
            obscureText: isPassShown ? false : true,
          ),
          SizedBox(height: 25),
          // GestureDetector(
          //     child: Text(
          //       'Ganti Password',
          //       style: TextStyle(
          //         fontFamily: 'Muli',
          //         fontSize: 15,
          //         fontWeight: FontWeight.w600,
          //         color: Theme.of(context).primaryColor,
          //         decoration: TextDecoration.underline,
          //       ),
          //     ),
          //     onTap: () {
          //       isEditingPassword = true;
          //       setState(() {});
          //     }),
        ],
      ),
    );
  }
}
