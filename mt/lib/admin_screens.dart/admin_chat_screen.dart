import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../models/firebase_constants.dart';
import './dmin_chat_detail.dart';


class AdminChat extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    
  final Widget tempWidget=Center(child:CircularProgressIndicator());

    return FirebaseAnimatedList(
          defaultChild: tempWidget,
          query: kFirebaseDbRef.child('chats'),
          sort: (a, b) => b.key.compareTo(a.key),
          padding: EdgeInsets.all(8.0),
        
          itemBuilder: (BuildContext ctx, DataSnapshot snapshot,
                  Animation<double> animation, int idx) =>
              ChatList(snapshot, animation,idx),
        );
  }


  
}

class  ChatList extends StatefulWidget {
  final DataSnapshot snapshot;
  final Animation animation;
  int index;

  ChatList(this.snapshot,this.animation,this.index);

  @override
  _ChatListState createState() => _ChatListState();
}


class _ChatListState extends State<ChatList> {

  String userName='User';
  String userImage='User';
  Map<String,String>userInfo;
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //userName=widget.snapshot.value['byUser'];
    userImage='User: '+(widget.index+1).toString();
    return ListTile(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
        builder: (_) { return AdminChatDetailScreen(widget.snapshot.key);}
      ),
      ) ,//AdminChatDetailScreen(),
      leading: CircleAvatar(
        child: Text('U'),
        backgroundColor: Colors.blueAccent,
      ),

      title: Text(userImage),
    );
  }
}


