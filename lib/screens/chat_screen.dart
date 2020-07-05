import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat_screen';

  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(bottom: 50),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Chat',
                      style: TextStyle(
                        fontFamily: 'Muli',
                        fontSize: 40,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            bottom: 15,
                          ),
                          prefixIcon: Icon(Icons.search),
                          labelText: 'Cari nama/group halaqah...',
                          alignLabelWithHint: false,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        // focusNode: _namaFocus,
                        textAlignVertical: TextAlignVertical.top,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (val) {
                          // FocusScope.of(context).requestFocus(_usernameFocus);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    top: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
