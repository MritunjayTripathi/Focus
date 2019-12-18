import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/recieved_message_ui.dart';
import '../widgets/sent_message_ui.dart';

import '../models/user.dart';
import '../models/firebase_constants.dart';

class AdminChatDetailScreen extends StatefulWidget {
  static String route = '/AdminChatDetailScreens';
  final String userId;
  AdminChatDetailScreen(this.userId);

  @override
  _AdminChatDetailScreenState createState() => _AdminChatDetailScreenState();
}

class _AdminChatDetailScreenState extends State<AdminChatDetailScreen> {

  DatabaseReference _firebaseMsgDbRef = kFirebaseDbRef;
  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;

  @override
  void initState() {
    super.initState();
    this._firebaseMsgDbRef = kFirebaseDbRef.child('chats').child(widget.userId);
  }
  
  final Widget tempWidget=Center(child:CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('AdminChatDetailScreen With Admin'),
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

  // Builds the list of AdminChatDetailScreen messages.
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
      child: 2 == byWhom
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
      'byWhom': 2,
      'chatBody': text,
        'senderName':'Admin',
    });
  }
}
