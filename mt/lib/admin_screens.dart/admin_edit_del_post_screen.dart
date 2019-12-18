import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/firebase_constants.dart';
import './admin_edit_del_post_detail_screen.dart';

class AdminEditDelPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Widget tempWidget=Center(child :CircularProgressIndicator());

  // Widget tempWidget=Center(child:Column(
  //   children: <Widget>[
  //     Image.asset('assets/images/dart_bird.png'),
  //     Divider(),
  //     CircularProgressIndicator(),
  //   ],
  // ));

    return FirebaseAnimatedList(
      defaultChild: tempWidget,
      query: kFirebaseDbRef.child('post'),
      sort: (a, b) => b.key.compareTo(a.key),
      padding: EdgeInsets.all(8.0),
      itemBuilder: (BuildContext ctx, DataSnapshot snapshot,
              Animation<double> animation, int idx) =>
          PostList(snapshot, animation),
    );
  }
}

class PostList extends StatefulWidget {
  final DataSnapshot snapshot;
  final Animation animation;

  PostList(this.snapshot, this.animation);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  void initState() {
    print(widget.snapshot.value);

    super.initState();
  }

  void delPost(String postId)async {
     await kFirebaseDbRef.child('post').child(postId).remove();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_){
              print(widget.snapshot.value);
              return AdminPostEDDetailScreen(widget.snapshot.value);
            }
          ));
        },
        leading: CircleAvatar(
          child: Image.network(widget.snapshot.value['userImage']),//Text(widget.snapshot.value['byUser']),
          backgroundColor: Colors.blueAccent,
        ),
        title: Text(
          widget.snapshot.value['title'], style: TextStyle(color: Colors.black),
          maxLines: 3,
        ),
        subtitle: Text(widget.snapshot.value['content'],maxLines: 2,),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: (){delPost(widget.snapshot.key);},
        ),
        
      ),
    );
  }
}
