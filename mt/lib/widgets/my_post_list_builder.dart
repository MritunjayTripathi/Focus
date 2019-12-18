import 'package:flutter/material.dart';
import 'package:mt/models/post.dart';
//import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
// import '../providers/post_provider.dart';
// import '../widget/posts.dart';
//import '../widget/create_new_post.dart';
import '../provider/posts.dart';
import '../models/post.dart';
import '../widgets/single_my_post_tile.dart';


class MyPostListBuilder extends StatelessWidget {
 
   @override
  Widget build(BuildContext context) {

    final postData=Provider.of<Posts>(context).getMyPosts;

    final myPost = postData;
    print(myPost);
  

    return ListView.builder(
          itemCount:myPost!=null? myPost.length:0,
          itemBuilder: (context, i) =>Column(
                children: [
                    SingleMyPostTile(
                        description: myPost[i].content,
                        id: myPost[i].postId,
                        tag: myPost[i].tags,
                        topic: myPost[i].title,
                        username: myPost[i].byUser,
                 
                    ),
                    Divider(),
                ],
          ),
          
         );
  }
}