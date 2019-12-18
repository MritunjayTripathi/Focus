import 'package:flutter/material.dart';

import '../models/web_post.dart';
import '../widgets/bottom_navigation_in_post_detail.dart';

class PostDetailFromWebScreen extends StatelessWidget {
  static final String route = '/post-detail-from-web-screen';

  @override
  Widget build(BuildContext context) {
    final postObject = ModalRoute.of(context).settings.arguments as WebPost;
  

    print('Post Object in post By Web Detail page');
    print(postObject);

    final appBar = AppBar(
      title: Text(
        'Focus',
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
    );

    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    // Fetchin Information

    final dateOfPost =postObject!=null? (postObject.dateCreated!=null?postObject.dateCreated:"No Date"):"No Date";
    final userOfPost =postObject!=null? (postObject.byUser!=null?postObject.byUser:"No User"):"No User";
    final userImgUrl =
        'https://www.hawtcelebs.com/wp-content/uploads/2019/04/josephine-langford-for-cosmopolitan-magazine-april-2019-2_thumbnail.jpg';
    final postImgUrl =
        'https://secure.meetupstatic.com/photos/event/e/6/9/2/600_464159026.jpeg';

    final String postTitle =
       postObject!=null? (postObject.title == null ? "Android" : postObject.title):" No Title";
    final String postDesc = postObject!=null?(postObject.content!=null?postObject.content: "No Body"):"No Body";
    final topic1 = "No Tags";//postObject!=null? postObject.tags:"No Tags Defined";
    final noOfUpvotes = 4;
    final noOfDownvotes = 5;

    final topic1chip = Chip(
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

    final topics = [
      Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: topic1chip,
      ),
    ];

    final titleContainer = ListTile(
      title: Text(
        postTitle,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Wrap(
        children: topics,
      ),
    );

    final hero = GestureDetector(
      onTap: () {
        //  Navigator.of(context).pushNamed(ProfileScreen.tag);
      },
      child: Hero(
        tag: 'UserName',
        child: CircleAvatar(
          radius: h * 0.04,
          backgroundImage: NetworkImage(
            userImgUrl,
          ),
        ),
      ),
    );
    /*
  Fetch User Name and Detail
  */

    final userContainer = FittedBox(
      fit: BoxFit.scaleDown,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
         Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0), //bottom: 16.0),
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                      "No User",//userOfPost,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey),
                    ),
                  )),
            ],
          ),
        // Date Of Post Goes Here... Can Remove below code simply to remove Dat Of Post
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              dateOfPost,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey),
            ),
          ),
        ),
      ],
    ),);

    /*
    Obtain Post Image
    */
    final imageContainer = Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Center(
        child: Image.network(postImgUrl),
      ),
    );

    final textContainer = Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade100,
          width: 2.0,
          style: BorderStyle.solid,
        ),
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      width: w * 0.9,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Text(
          postDesc,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          textAlign: TextAlign.justify,
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: true,
          left: true,
          right: true,
          top: true,
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                titleContainer,
                Divider(),
                userContainer,
                Divider(),
                imageContainer,
                Divider(),
                textContainer,
                Divider(),
              ],
            ),
          ),
        ),
      ),
      //bottomNavigationBar:
        //  BottomNavigationPostDetail(noOfUpvotes, noOfDownvotes),
    );
  }
}
