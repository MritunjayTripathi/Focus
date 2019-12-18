import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import '../widget/create_new_post.dart';
//import '../widget/product_tile.dart';
//import '../providers/post_provider.dart';
import '../provider/posts.dart';
import '../widgets/create_new_post.dart';
import '../widgets/single_my_post_tile.dart';
import '../widgets/my_post_list_builder.dart';
import '../provider/user_provider.dart';
import '../models/firebase_constants.dart';
import '../models/post.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class MyPostsScreen extends StatefulWidget {
  static final String route = '/my-post-screen';
  @override
  _MyPostsScreenState createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  var isInit = true;

  List<String> myPostIdList;
  List<PostInfo> myPostList;

  void loadMe() async {
    //jsonData=Provider.of<Posts>(context).getMyPosts;
    print('inside loadingg');
    for (String id in myPostIdList) {
      var url = 'https://focus-bbca0.firebaseio.com/post/$id.json';
      print(id);

      try {
        var data = await http.get(url);
        var jsonData = json.decode(data.body) as Map<String, dynamic>;
        if ((jsonData != null)) {

          print(jsonData);

        // PostInfo singlePostItem = PostInfo(
        //     title: jsonData['title'],
        //     content: jsonData['content'],
        //     byUser: jsonData['byUser'],
        //     tags: jsonData['tags'],
        //     postId: ,
        //     noOfUpvotes: jsonData['noOfUpvotes'],
        //     noOfDownVotes: jsonData['noOfDownvotes'],
        //     userImage: jsonData['userImage']);
  
         
          setState(() {
            // ProfileScreenStalker.imageUri="#";
            // ProfileScreenStalker.usersPost="";
            // ProfileScreenStalker.usersUpvotes="0";
            // ProfileScreenStalker.usersLevel="Beginner";
            // imageUrl =
            //     jsonData['imageUri'] == null ? "#" : jsonData['imageUri'];
            // username = jsonData['name'] == null ? "" : jsonData['name'];
            // userUpvotes = jsonData['noOfUpvotes'] == null
            //     ? "0"
            //     : jsonData['noOfUpvotes'].toString();
            // flag = 1;
          });

          print('I did set the data');
        }
        print('I got this User info After stalking ');
        print(jsonData);
      } catch (e) {
        print('this is some error in stalking');
        print(e);
      }
    }
  }

  @override
  void initState() {
    myPostIdList =
        Provider.of<UserProvider>(context, listen: false).getMyPostIdList;
    print('I am getting all my posts Id');
    print(myPostIdList);
    loadMe();
    //Provider.of<Posts>(context,listen: false).populateMyPostList(myPostIdList);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {}
    isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _refreshPost(BuildContext context) async {
    return Provider.of<Posts>(context).populateMyPostList;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return _refreshPost(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Posts'),
          backgroundColor: Colors.blue.shade500,
        ),
        body: MyPostListBuilder(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(CreateNewPost.route);
            setState(() {});
          },
        ),
      ),
    );
  }
}
