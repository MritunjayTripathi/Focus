import 'package:flutter/material.dart';
import 'package:mt/models/post.dart';
import 'package:provider/provider.dart';

import '../provider/posts.dart';
import '../models/post.dart';
import '../screen/post_detail_screen.dart';
import '../provider/user_provider.dart';
import '../provider/qna_provider.dart';

class PostItem extends StatefulWidget {
  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  void initState() {
    super.initState();
    Provider.of<Posts>(context, listen: false).getPostInfo();

    Provider.of<UserProvider>(context, listen: false).getUserInfo();
    Provider.of<QnA>(context, listen: false).getQnA();
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Posts>(context);
    final List<PostInfo> postList = post.getPosts;
    print(" this is the postlist length");
    print(postList.length);
   // print(postList);

    return ListView.builder(
      itemCount: postList.length,
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 1.5,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          child: PostTile(postList[index]),
        );
      },
    );
  }
}

class PostTile extends StatefulWidget {
  //const PostTile({Key key}) : super(key: key);

  final postObject;

  PostTile(this.postObject);

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    //final w = MediaQuery.of(context).size.width;
    final userImgUrl = widget.postObject.userImage;
    // 'https://www.hawtcelebs.com/wp-content/uploads/2019/04/josephine-langford-for-cosmopolitan-magazine-april-2019-2_thumbnail.jpg';

    final userImg = Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CircleAvatar(
        radius: h * 0.04,
        backgroundImage: userImgUrl == '#'
            ? AssetImage('assets/images/dart_bird.png')
            : NetworkImage(
                userImgUrl,
              ),
      ),
    );

    //final postTitle =
    //  'Title is here.This is The Question. Aur Tanu? Cool. Tu Beer Hai! Just to check Text Overflow Within a card Widget.';
    //print(s);
    //final String postDesc =
    //  'This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.';
    final String topic1 = widget.postObject.tags;
    final String topic2 = widget.postObject.tags;
    /*
    Chip Widget Is HERE .... Format Of CHIP Widget For TOPIC
    */
    final chip1 = Chip(
      avatar: CircleAvatar(
        child: Text(
          topic1.substring(0, 1),
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey.shade300,
      label: Text(
        topic1,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 10),
      ),
    );
    final chip2 = Chip(
      avatar: CircleAvatar(
        child: Text(
          topic2.substring(0, 1),
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey.shade300,
      label: Text(
        topic2,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 10),
      ),
    );

    final topics = [
      Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: chip1,
      ),
      Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: chip2,
      ),
    ];

    final bookmarkedPost = ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          PostDetailScreen.route,
          arguments: widget.postObject,
        );
        print('someone pressed it');
        // Navigator.of(context).pushNamed(PostDetailScreen.tag);
      },
      //leading: userImg,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          userImg,
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              child: Text(
                widget.postObject.title.length > 107
                    ? widget.postObject.title.substring(0, 104) + '...'
                    : widget.postObject.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.postObject.content.length > 150
                ? widget.postObject.content.substring(0, 150) + '...'
                : widget.postObject.content,
          ),
          //Row(children: chipsinRow),//For topics
          Wrap(
            children: topics,
          )
          //Text('Topic1, Topic2')
        ],
      ),
      isThreeLine: true,
    );

    return bookmarkedPost;
  }
}
