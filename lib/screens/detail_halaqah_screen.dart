import 'package:alhiqniy/providers/p_user.dart';
import 'package:alhiqniy/screens/presence_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailHalaqahScreen extends StatefulWidget {
  static const routeName = '/deatil_halaqah_screen';

  const DetailHalaqahScreen({Key key}) : super(key: key);

  @override
  _DetailHalaqahScreenState createState() => _DetailHalaqahScreenState();
}

class _DetailHalaqahScreenState extends State<DetailHalaqahScreen> {
  UserType _userType;

  @override
  void initState() {
    super.initState();
    setState(() {
      _userType = Provider.of<UserProvider>(context, listen: false).userType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  bottom: 15,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Transform.translate(
                    offset: Offset(10, 0),
                    child: BackButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 35, right: 35),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100],
                        offset: Offset(0, 8),
                        blurRadius: 25,
                      )
                    ],
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/list1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Ustadz Fulan bin Fulan',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Ustadz Fulan bin Fulan',
                style: TextStyle(
                  fontFamily: 'Muli',
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Image.asset(
                    'assets/icons/live2.png',
                    height: 12.5,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Live',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    ' | 12 Thullab hadir',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Container(
                margin: EdgeInsets.only(
                  bottom: 40,
                  right: 10,
                ),
                child: Column(
                  children: <Widget>[
                    OutlineButton(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      padding: EdgeInsets.all(15),
                      shape: CircleBorder(),
                      child: Icon(Icons.arrow_forward),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(PresenceScreen.routeName),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Masuk Halaqah',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: 'OpenSans',
                      ),
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
