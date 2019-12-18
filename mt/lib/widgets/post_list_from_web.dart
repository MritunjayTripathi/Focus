/*import 'package:flutter/material.dart';
import 'package:mt/models/post.dart';
import 'package:provider/provider.dart';

import '../screen/post_detail_screen.dart';
import '../provider/posts_by_websites.dart';

class PostListFromWeb extends StatefulWidget {
  @override
  _PostListFromWebState createState() => _PostListFromWebState();
}

class _PostListFromWebState extends State<PostListFromWeb> {


  @override
  void initState() {
    super.initState();
    Provider.of<PostsByWeb>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {

    //If PostByWeb(provider) changes (which is registered in main.dart)  we get the new Instance of post

    final post = Provider.of<PostsByWeb>(context);
    //we get the getMethos
    Provider.of<PostsByWeb>(context, listen: false).fetchData();
    final List<PostInfo> postList = post.getPosts;

    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          child: GestureDetector(
            //ALSO HAVE TO PASS ARGUMENTS
            onTap: () => Navigator.of(context).pushNamed(
              PostDetail.route,
              arguments: {
                'postId': postList[index].postId,
              },
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text('User'),
                  ),
                ),
              ),
              title: Text(postList[index].title),
              subtitle: Text(postList[index].content),
              isThreeLine: true,
            ),
          ),
        );
      },
      itemCount: postList == null ? 0 : postList.length,
    );
  }
}
*/