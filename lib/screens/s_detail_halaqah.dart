import 'package:alhiqniy/screens/s_call.dart';
import 'package:alhiqniy/screens/s_presence.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailHalaqahScreen extends StatefulWidget {
  static const routeName = '/deatil_halaqah_screen';

  const DetailHalaqahScreen({Key key}) : super(key: key);

  @override
  _DetailHalaqahScreenState createState() => _DetailHalaqahScreenState();
}

class _DetailHalaqahScreenState extends State<DetailHalaqahScreen> {
  Future<void> onJoin() async {
    try {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallScreen(
            channelName: 'halaqah',
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> _handleCameraAndMic() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
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
                child: AspectRatio(
                  aspectRatio: 3.5 / 4,
                  child: Container(
                    padding: const EdgeInsets.only(left: 35, right: 35),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200],
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
              ),
              SizedBox(height: 15),
              Text(
                'Halaqah Online',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Mahad Imam Ahmad\nbin Hambal',
                style: TextStyle(
                  fontFamily: 'Muli',
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
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
                  // Text(
                  //   ' | 12 Thullab hadir',
                  //   style: TextStyle(
                  //     fontFamily: 'OpenSans',
                  //     fontSize: 12,
                  //     color: Colors.grey,
                  //   ),
                  // ),
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
                      highlightedBorderColor: Colors.grey,
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      padding: EdgeInsets.all(15),
                      shape: CircleBorder(),
                      child: Icon(Icons.arrow_forward),
                      // onPressed: () => Navigator.of(context)
                      //     .pushNamed(PresenceScreen.routeName),
                      onPressed: onJoin,
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
