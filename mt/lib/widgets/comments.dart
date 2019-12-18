import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../models/firebase_constants.dart';
import '../widgets/single_comment.dart';

class Comments extends StatelessWidget {
  
  final String postId;
  Comments(this.postId);

  final DatabaseReference comments=kFirebaseDbRef;

  @override
  Widget build(BuildContext context) {    
    final heightOfDevice = MediaQuery.of(context).size.height;
    
    final Widget tempWidget=Center(child: CircularProgressIndicator(),);
    print("I was in Comments Widget");

    return
      FirebaseAnimatedList(
        defaultChild: tempWidget,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
          query: comments.child('commentsTable').child(postId),
            sort: (a, b) => b.key.compareTo(a.key),
          itemBuilder: (BuildContext ctx,DataSnapshot snapshot,
                Animation<double>animation,int index) => _commentsFromSnapshot(snapshot,animation,heightOfDevice),
                
        );
      
    
  }
}

Widget _commentsFromSnapshot(DataSnapshot snapshot,Animation<double> animation,double heightOfDevice){

  print('In the Comment');
  print(snapshot);

  final String commentContent=snapshot.value['commentContent'];
  final String userName=snapshot.value['userName'];
  final String userImage=snapshot.value['userImage'];
  

  return SingleComment(userName, commentContent, userImage,heightOfDevice );

}