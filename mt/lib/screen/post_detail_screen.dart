import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mt/screen/profile_stalker_screen.dart';
import 'package:mt/widgets/comments.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';
//import './profile_Screen.dart';
//import './upload_image.dart';

import '../models/post.dart';
import '../widgets/single_comment.dart';
import '../widgets/bottom_navigation_in_post_detail.dart';
import '../models/firebase_constants.dart';

class PostDetailScreen extends StatelessWidget {
  static final String route = '/post-detail-screen';
  static String comBack;

  @override
  Widget build(BuildContext context) {
   
    final postObject = ModalRoute.of(context).settings.arguments as PostInfo;

    print('Post Object in post By User Detail page');
    print(postObject);

        
    final appBar = AppBar(
      title: Text(
        'Focus',
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
    );


    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    TextEditingController commentController=TextEditingController();
    commentController.text = PostDetailScreen.comBack;



    //Fetching  Information

    final dateOfPost = '20/09/2019';
    final userOfPost = postObject.byUser;
    final userImgUrl = postObject.userImage;
       // 'https://www.hawtcelebs.com/wp-content/uploads/2019/04/josephine-langford-for-cosmopolitan-magazine-april-2019-2_thumbnail.jpg';
    final postImgUrl =
        'https://timedotcom.files.wordpress.com/2016/07/spiderman-homecoming.jpg';
    
    final String postTitle = postObject.title;
    final String postDesc = postObject.content;
    final topic1 = postObject.tags;
    final noOfUpvotes=postObject.noOfUpvotes==null ? 0:postObject.noOfUpvotes;
    final noOfDownvotes=postObject.noOfDownVotes ==null ? 0:postObject.noOfDownVotes;
    final postId=postObject.postId;






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
         Navigator.of(context).pushNamed(ProfileScreenStalker.route);
      },
      child: Hero(
        tag: 'UserName',
        child: CircleAvatar(
          radius: h * 0.04,
          backgroundImage: userImgUrl=='#'?AssetImage('assets/images/dart_bird.png'):NetworkImage(
            userImgUrl,
          ),
          /*child: Image.network(
                              'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
                              //fit: Boxfit.cover,
                            ),*/
        ),
      ),
    );



    /*
  Fetch User Name and Detail
  */
    final userContainer = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 8.0), //,bottom: 16.0),
                child: hero),
            Padding(
                padding: const EdgeInsets.only(right: 16.0), //bottom: 16.0),
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                    userOfPost,
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
                  fontSize: 12, fontWeight: FontWeight.w300, color: Colors.grey),
            ),
          ),
        ),
      ],
    );
    /*
    Obtain Post Image
    */
    final imageContainer = Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Center(
        child: FadeInImage.assetNetwork(
        fadeInCurve: Curves.easeIn,
        fadeInDuration: Duration(milliseconds: 300),
        image: postImgUrl,
        placeholder: 'assets/images/dart_bird.png',
        /*write this in 
        assets:
          - assets/images/dart_bird.png
        */
        //height: 200,
      )),
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

/*
Obtain Comments Here
*/

    final comment1 =
        'This is the Comment. By corresponding user. This is a Long Comment Lets See What Happens. This is the Comment. By corresponding user. This is a Long Comment Lets See What Happens. This is the Comment. By corresponding user. This is a Long Comment Lets See What Happens. This is the Comment. By corresponding user. This is a Long Comment Lets See What Happens. This is the Comment. By corresponding user. This is a Long Comment Lets See What Happens. This is the Comment. By corresponding user. This is a Long Comment Lets See What Happens. ';
    final comment2 = 'This is the Comment. By corresponding user.';
    final userName = 'Josephine Langford';

    final chip1 = SingleComment(userName, comment1, userImgUrl, h);
    final chip2 = SingleComment(userName, comment2, userImgUrl, h);

    final writeComment = Flexible(
      //padding: const EdgeInsets.only(top:15.0,),
      child: TextField(
        onChanged: (text){
          PostDetailScreen.comBack = text;
        },
        controller: commentController,
        minLines: 1,
        maxLines: 15,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: 'Write your comment here',
          //filled: true,
          //fillColor: Color(0xFFDBEDFF),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );

    final writeCommentRow =  Container(
      width: w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          writeComment,
          IconButton(
            tooltip: 'Comment',
            icon: Icon(Icons.send),
            onPressed: () {
              if(commentController.text != '')
              {kFirebaseDbRef.child('commentsTable').child(postId).push().set({
                'commentContent':commentController.text,
                'userImage':userImgUrl,
                'userName':userName,
              });}
             commentController.clear();
             PostDetailScreen.comBack = '';
            },

          ),
        ],
      ),
    );


  
    print("I am About  to go to Comments Widget");

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
                //Row( mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[user1, writeComment],),
                writeCommentRow,
                Divider(),
                Comments(postId),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationPostDetail(noOfDownVote: noOfDownvotes,noOfUpvote: noOfUpvotes,postId: postId,),
    );
  }
}
