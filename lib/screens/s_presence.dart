import 'dart:async';

import 'package:alhiqniy/providers/p_user.dart';
import 'package:alhiqniy/screens/s_call.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class PresenceScreen extends StatefulWidget {
  static const routeName = '/presence_screen';

  const PresenceScreen({Key key}) : super(key: key);

  @override
  _PresenceScreenState createState() => _PresenceScreenState();
}

class _PresenceScreenState extends State<PresenceScreen> {
  UserType _userType;
  String channelName =
      '12345'; //TODO: later on change this to the halaqah title + date

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
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                    bottom: 15,
                  ),
                  child: Transform.translate(
                    offset: Offset(-30, 0),
                    child: BackButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Text(
                  'Kehadiran\nThullab',
                  style: TextStyle(
                    fontFamily: 'Muli',
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                _userType == UserType.mudaris
                    ? SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                              bottom: 5,
                              right: 35,
                            ),
                            child: RichText(
                              text: TextSpan(
                                text:
                                    'Jika halaqah telah dirasa siap, silahkan ketua kelas halaqah menekan tombol ',
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 14,
                                  color: Colors.grey,
                                  height: 1.75,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' \'check box\' ',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' dan ',
                                  ),
                                  TextSpan(
                                    text: ' \'Masuki Halaqah\'',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 36.0),
                    // child: ThullabCardList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: 47,
                    margin: EdgeInsets.only(
                      bottom: 40,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          _userType == UserType.thullab
                              ? 'MASUK HALAQAH'
                              : 'MULAI HALAQAH',
                          style: TextStyle(
                            fontFamily: 'Muli',
                            fontWeight: FontWeight.w700,
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
                          onPressed: onJoin,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    try {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: channelName,
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
}

// class ThullabCardList extends StatefulWidget {
//   const ThullabCardList({Key key}) : super(key: key);

//   @override
//   _ThullabCardListState createState() => _ThullabCardListState();
// }

// class _ThullabCardListState extends State<ThullabCardList> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: listMudaris.length,
//       itemBuilder: _buildCardListItem,
//       shrinkWrap: true,
//     );
//   }

//   Widget _buildCardListItem(BuildContext context, int index) {
//     return Ink(
//       child: InkWell(
//         onTap: () {},
//         child: Container(
//           constraints: BoxConstraints(minHeight: 46),
//           margin: EdgeInsets.symmetric(vertical: 10),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(100),
//                   child: Image.asset(
//                     listMudaris[index].gambar,
//                     width: 42,
//                     height: 42,
//                   ),
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15, top: 10),
//                 child: Text(
//                   listMudaris[index].nama,
//                   style: TextStyle(
//                     fontFamily: 'Muli',
//                     color: Colors.black,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
