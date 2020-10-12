import 'package:flutter/material.dart';
import 'package:mt/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import '../screen/post_detail_screen.dart';
import '../provider/posts.dart';

class PostTileSimple extends StatelessWidget {
  final PostInfo postInfo;
  PostTileSimple(this.postInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
              splashColor: Colors.lightBlue[100],
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(
            PostDetailScreen.route,
            arguments: postInfo,
          );
        },
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text(postInfo.byUser),
            ),
          ),
        ),
        title: Text(
          postInfo.title,
          maxLines: 2,
        ),
        subtitle: Text(
          postInfo.content,
          maxLines: 1,
        ),
        trailing: IconButton(
          tooltip: "remove",
          onPressed: () {
            print('Bookmarked button worked  :) ');
            Provider.of<UserProvider>(context).bookmarkMe(postInfo.postId, 0);
            // SnackBar(
            //   content: Text('Bookmark Removed',textAlign: TextAlign.end,),
            //   duration: Duration(seconds: 2),
            
            //   action: SnackBarAction(label: 'Undo',onPressed:()=> Provider.of<UserProvider>(context).bookmarkMe(postInfo.postId, 1),),
            // );
            
                  
          },
          focusColor: Colors.blueGrey,
          icon: Icon(Icons.bookmark, color: Colors.blue),
        ),
        isThreeLine: true,
      ),
     ),
    );
  }
}
