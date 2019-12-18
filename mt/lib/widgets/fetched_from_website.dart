import 'package:flutter/material.dart';
import 'package:mt/models/web_post.dart';
import 'package:mt/screen/post_detail_from_web_screen.dart';
import 'package:provider/provider.dart';

import '../provider/posts_by_websites.dart';

class FetchedFromWebsite extends StatefulWidget {
  @override
  _FetchedFromWebsiteState createState() => _FetchedFromWebsiteState();
}

class _FetchedFromWebsiteState extends State<FetchedFromWebsite> {
  @override
  void initState() {
    super.initState();
    Provider.of<PostsByWeb>(context, listen: false).fetchData('Java');
    //Change here
  }

  @override
  Widget build(BuildContext context) {
    final ob = Provider.of<PostsByWeb>(context);
    List<WebPost> postList = ob.getPosts;

    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
          child: GestureDetector(
            
            child: PostTile(postList[index]),
            
          ),
        );
      },
      itemCount: postList == null ? 0 : postList.length,
    );
  }
}

class PostTile extends StatelessWidget {
  //const PostTile({Key key}) : super(key: key);
  final postObject;

  PostTile(this.postObject);

    
  // final String postTitle=postObject.title;
  // final String postContent;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    //final w = MediaQuery.of(context).size.width;
    final userImgUrl =
        'https://www.hawtcelebs.com/wp-content/uploads/2019/04/josephine-langford-for-cosmopolitan-magazine-april-2019-2_thumbnail.jpg';

    final userImg = Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CircleAvatar(
        radius: h * 0.04,
        backgroundImage: AssetImage('assets/images/dart_bird.png'),
      ),
    );
//  'This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.This Post Description is Here.';
    final String topic1 = 'Data Structure';
    final String topic2 = 'Algorithm';
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
        Navigator.of(context).pushNamed(PostDetailFromWebScreen.route,arguments: postObject);
      },

      //  "title": postObject.title,
      //     "content" :postObject.content,
      //     "dateCreated" :postObject.dateCreated,
      //     "tags":postObject.tags,
      //     "byUser":postObject.byUser,


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
                //postTitle.length>107? postTitle.substring(0,104)+ '...': postTitle,
                postObject.title == null ? 'Unknown' : postObject.title,
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
            postObject.shortDescription == null
                ? 'no Body'
                : postObject.shortDescription.length > 150
                    ? postObject.shortDescription.substring(0, 150) + '...'
                    : postObject.shortDescription,
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
