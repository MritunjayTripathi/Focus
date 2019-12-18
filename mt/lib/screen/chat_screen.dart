import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/recieved_message_ui.dart';
import '../widgets/sent_message_ui.dart';

import '../models/user.dart';
import '../models/firebase_constants.dart';

class Chat extends StatefulWidget {
  static String route = '/chats';
  const Chat({Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  DatabaseReference _firebaseMsgDbRef = kFirebaseDbRef;
  FirebaseUser _user;
  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;

  @override
  void initState() {
    super.initState();

    //final now = DateTime.now().toUtc();

    kFirebaseAuth.currentUser().then((user) {
      print('Init Method of Chat Screen');
      this._user = user;
    }).then((user) {
      this._firebaseMsgDbRef =
          kFirebaseDbRef.child('chats').child(this._user.uid);

      print(
          'Rightnow in this init Oure DbRef is ${this._firebaseMsgDbRef} \n ans Our user is ${this._user}');
    });
    //this._firebaseMsgDbRef =
    //    kFirebaseDbRef.child('chats').child('gHCxtaNjrXTwLka2A854EbfYmfy2');

    this._firebaseMsgDbRef = kFirebaseDbRef.child('chats').child(User.userUid);
  }

  
  final Widget tempWidget=Center(child:CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Chat With Admin'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            _buildMessagesList(),
            Divider(height: 2.0),
            _buildComposeMsgRow(),
          ],
        ),
      ),
    );
  }

  // Builds the list of chat messages.
  Widget _buildMessagesList() {
    return Flexible(
      child: Scrollbar(
        child: FirebaseAnimatedList(
          defaultChild: tempWidget,
          query: _firebaseMsgDbRef,
          sort: (a, b) => b.key.compareTo(a.key),
          padding: EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (BuildContext ctx, DataSnapshot snapshot,
                  Animation<double> animation, int idx) =>
              _messageFromSnapshot(snapshot, animation),
        ),
      ),
    );
  }

  // Returns the UI of one message from a data snapshot.
  Widget _messageFromSnapshot(
      DataSnapshot snapshot, Animation<double> animation) {
    int byWhom = snapshot.value['byWhom'];
    String chatBody = snapshot.value['chatBody'];
    String senderName=snapshot.value['senderName'];
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      axisAlignment: 0.0,
      child: User.myType == byWhom
          ? SentMsgUI(
              currUserImgUrl: User.imgUrl,
              currUserName: senderName,
              sendMsg: chatBody,
            )
          : RecievedMsgUI(
              otherUserImgUrl: null,
              otherUserName: senderName,
              recievedMsg: chatBody,
            ),
    );
  }

  // Builds the row for composing and sending message.
  Widget _buildComposeMsgRow() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: TextField(
              keyboardType: TextInputType.multiline,
              // Setting maxLines=null makes the text field auto-expand when one
              // line is filled up.
              maxLines: null,
              maxLength: 200,
              decoration: InputDecoration.collapsed(hintText: "Send a message"),
              controller: _textController,
              onChanged: (String text) =>
                  setState(() => _isComposing = text.length > 0),
              onSubmitted: _onTextMsgSubmitted,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isComposing
                ? () {
                    _onTextMsgSubmitted(_textController.text);
                    setState(() {
                      _isComposing = false;
                    });
                  }
                : null,
          ),
        ],
      ),
    );
  }

  // Triggered when text is submitted (send button pressed).
  Future<Null> _onTextMsgSubmitted(String text) async {
    // Clear input text field.
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    // Send message to firebase realtime database.
    _firebaseMsgDbRef.push().set({
      'byWhom': User.myType,
      'chatBody': text,
        'senderName':User.myType==1?User.myName:'Admin',
    });
    //kFirebaseAnalytics.logEvent(name: 'send_message');
  }
}
