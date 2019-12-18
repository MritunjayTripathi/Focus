import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:mt/models/post.dart';

import './admin_edit_del_post_detail_screen.dart';
import '../models/firebase_constants.dart';

class AdminPostPermission extends StatelessWidget {

  final Widget tempWidget=Center(child:CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
      defaultChild: tempWidget ,
      query: kFirebaseDbRef.child('pendingPost'),
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

  void rejectPost(String postId) async {
    await kFirebaseDbRef.child('pendingPost').child(postId).remove();
  }

  void acceptPost(String postId,Map<dynamic,dynamic> post) async {
    await kFirebaseDbRef.child('post').push().set(post);
    await kFirebaseDbRef.child('pendingPost').child(postId).remove();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            print(widget.snapshot.value);
            return AdminPostEDDetailScreen(widget.snapshot.value);
          }));
        },
        leading: IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: () {
              rejectPost(widget.snapshot.key);
            },
          ),
        
        title: Row(
          children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(widget.snapshot
              .value['userImage']), //Text(widget.snapshot.value['byUser']),
          backgroundColor: Colors.blueAccent,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.snapshot.value['title'],
            style: TextStyle(color: Colors.black),
            maxLines: 3,
          ),
        ),],),
        // subtitle: Text(
        //   widget.snapshot.value['content'],
        //   maxLines: 2,
        // ),
        trailing:IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              acceptPost(widget.snapshot.key,widget.snapshot.value);
            },
          ),
          
          
        
      ),
    );
  }
}
