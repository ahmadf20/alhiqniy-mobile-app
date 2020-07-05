import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import '../utils/keys.dart';

class CallPage extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String channelName;

  /// Creates a call page with given channel name.
  const CallPage({Key key, this.channelName}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;

  // Timer _timer;

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    initialize();
    //  _timer = Timer(const Duration(seconds: 1), () {
    //                           print(value);
    //                           if (value.isNotEmpty) {
    //                             getSearchResult(value);
    //                           }
    //                         });
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    await AgoraRtcEngine.setParameters(
        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
    await AgoraRtcEngine.joinChannel(null, widget.channelName, null, 0);
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    await AgoraRtcEngine.create(APP_ID);
    await AgoraRtcEngine.enableVideo();
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onError = (dynamic code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onJoinChannelSuccess = (
      String channel,
      int uid,
      int elapsed,
    ) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onLeaveChannel = () {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    };

    AgoraRtcEngine.onFirstRemoteVideoFrame = (
      int uid,
      int width,
      int height,
      int elapsed,
    ) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    };
  }

  int activeUid;
  int indexActiveView;

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<Widget> list = [
      AgoraRenderWidget(0, local: true, preview: true),
    ];
    for (var i = 0; i < _users.length; i++) {
      int uid = _users[i];
      list.add(Stack(
        children: <Widget>[
          AgoraRenderWidget(uid),
          GestureDetector(
              onTap: () {
                print(uid);
                if (activeUid == uid) {
                  setState(() {
                    activeUid = null;
                    indexActiveView = null;
                  });
                } else {
                  setState(() {
                    activeUid = uid;
                    indexActiveView = i + 1;
                  });
                }
              },
              child: Container(color: Colors.transparent)),
        ],
      ));
    }
    // _users.forEach((int uid) => list.add(Stack(
    //       children: <Widget>[
    //         AgoraRenderWidget(uid),
    //         GestureDetector(
    //             onTap: () {
    //               print(uid);
    //               setState(() {
    //                 activeUid=uid;
    //                 indexActiveView =
    //               });
    //             },
    //             child: Container(color: Colors.transparent)),
    //       ],
    //     )));
    print(list.length);
    // return list;
    return activeUid == null
        ? list
        : list.sublist(indexActiveView, indexActiveView + 1);
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
          children: <Widget>[_videoView(views[0])],
        ));
      case 2:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow([views[0]]),
            _expandedVideoRow([views[1]])
          ],
        ));
      case 3:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 3))
          ],
        ));
      case 4:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4))
          ],
        ));
      default:
    }
    return Container();
  }

  Widget _sidebar() {
    return Positioned(
      right: 25,
      bottom: 125,
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 50,
            height: 50,
            child: RawMaterialButton(
              onPressed: _onSwitchCamera,
              child: Icon(
                Icons.switch_camera,
                color: Colors.white,
                size: 20.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 2.0,
              fillColor: Colors.black38,
              padding: const EdgeInsets.all(12.0),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 50,
            height: 50,
            child: RawMaterialButton(
              onPressed: _onToggleMute,
              child: Icon(
                muted ? Icons.mic : Icons.mic_off,
                color: Colors.white,
                size: 20.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 2.0,
              fillColor: Colors.black38,
              padding: const EdgeInsets.all(12.0),
            ),
          )
        ],
      ),
    );
  }

  Widget _info() {
    return Positioned(
      left: 15,
      bottom: 125,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Ustadz Abu Fulan',
            style: TextStyle(
              fontFamily: 'Muli',
              fontSize: 26,
              color: Colors.white,
            ),
          ),
          Text(
            '15:10',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // RawMaterialButton(
          //   onPressed: _onToggleMute,
          //   child: Icon(
          //     muted ? Icons.mic : Icons.mic_off,
          //     color: muted ? Colors.white : Colors.blueAccent,
          //     size: 20.0,
          //   ),
          //   shape: CircleBorder(),
          //   elevation: 2.0,
          //   fillColor: muted ? Colors.blueAccent : Colors.white,
          //   padding: const EdgeInsets.all(12.0),
          // ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          // RawMaterialButton(
          //   onPressed: _onSwitchCamera,
          //   child: Icon(
          //     Icons.switch_camera,
          //     color: Colors.blueAccent,
          //     size: 20.0,
          //   ),
          //   shape: CircleBorder(),
          //   elevation: 2.0,
          //   fillColor: Colors.white,
          //   padding: const EdgeInsets.all(12.0),
          // )
        ],
      ),
    );
  }

  /// Info panel to show logs
  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return null;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _background() {
    return Positioned(
      bottom: 0,
      child: Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 1],
            colors: [
              Colors.transparent,
              Colors.black54,
            ],
          ),
        ),
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    AgoraRtcEngine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    AgoraRtcEngine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            _viewRows(),
            _background(),
            _info(),
            // _panel(),
            _sidebar(),
            _toolbar(),
          ],
        ),
      ),
    );
  }
}
