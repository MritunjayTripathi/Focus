import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mt/screen/my_bookmarks.dart';
import 'dart:convert';

import '../models/user.dart';
import '../models/firebase_constants.dart';
import './posts.dart';

class UserProvider with ChangeNotifier {
  User currentUser;

  DatabaseReference mref = kFirebaseDbRef;

  Map<String, dynamic> myFollowers = {};
  Map<String, dynamic> myInfo = {};
  Map<String, dynamic> voted = {};
  List<String> myBookmarks = [];
  List<String> myPosts = [];
  List<String> interest = [];

  List<String> get getMyBookmarksIdList {
    return [...myBookmarks];
  }

  List<String> get getMyPostIdList {
    return [...myPosts];
  }

  int voteType(String postId) {
    if (voted != null && voted.containsKey(postId)) {
      if (voted[postId] == 0) {
        return 1; //Downvoted
      } else
        return 2; //upvoted
      //Neither upvoted or downvoted
    } else {
      return 0;
    }
  }

  void bookmarkMe(String postId, type) {
    if (type == 0) {
      if (myBookmarks == null) return;

      if (myBookmarks.contains(postId)) myBookmarks.remove(postId);

      mref
          .child('users')
          .child(User.userUid)
          .child('Bookmarks')
          .child(postId)
          .remove();
    } else if (type == 1) {
      myBookmarks.add(postId);
      mref
          .child('users')
          .child(User.userUid)
          .child('Bookmarks')
          .child(postId)
          .set("1");
    }
    notifyListeners();

    print('Added in bookmarked List\n');
  }

  
  int bookmarkType(String postId) {
    if (myBookmarks != null && myBookmarks.contains(postId)) {
      return 1;
    } else {
      return 0;
    }
  }

  void upVote(String postId, int upVoteCount, int downVoteCount, int type) {
    if (type == 0) {
      if (voted != null && voted.containsKey(postId)) voted.remove(postId);
      //Updating votes in my profile that i removed upvoted from this Post
      mref
          .child('users')
          .child(User.userUid)
          .child('votes')
          .child(postId)
          .remove();

      mref
          .child('post')
          .child(postId)
          .update({'noOfUpvotes': upVoteCount, 'noOfDownvotes': downVoteCount});
    } else if (type == 2) {
      voted[postId] = type;

      //Updating votes in my profile that i upvoted this Post
      mref
          .child('users')
          .child(User.userUid)
          .child('votes')
          .child(postId)
          .set(type);

      //updating count in posts's  count
      mref
          .child('post')
          .child(postId)
          .update({'noOfUpvotes': upVoteCount, 'noOfDownvotes': downVoteCount});


    }
     //notifyListeners();
  }

  void downVote(String postId, int upVoteCount, int downVoteCount, int type) {
    if (type == 0) {
      if (voted != null && voted.containsKey(postId)) voted.remove(postId);
      mref
          .child('users')
          .child(User.userUid)
          .child('votes')
          .child(postId)
          .remove();

      mref
          .child('post')
          .child(postId)
          .update({'noOfUpvotes': upVoteCount, 'noOfDownvotes': downVoteCount});

         // voted[postId]=type;
    } else if (type == 1) {
      voted[postId] = type;
      mref
          .child('users')
          .child(User.userUid)
          .child('votes')
          .child(postId)
          .set(type);

      //if(voted.containsKey(postId))

      mref
          .child('post')
          .child(postId)
          .update({'noOfUpvotes': upVoteCount, 'noOfDownvotes': downVoteCount});
    }
   //  notifyListeners();
  }

  Future<void> getUserInfo() async {
    var url = 'https://focus-bbca0.firebaseio.com/users/${User.userUid}.json';

    try {
      var data = await http.get(url);
      var jsonData = json.decode(data.body) as Map<String, dynamic>;

      print("Getting User Info AF");
      //print(jsonData);



       List<String> tinterest = [];
      if (jsonData['interest'] != null) {
        jsonData['interest'].forEach((postId, postdata) {
          tinterest.add(postId);
        });

        print("this is tht Interest list $tinterest ");
      } else
        print("Got nothing in Interest list  ");

      interest = tinterest;


      List<String> tMyBookmarks = [];
      if (jsonData['Bookmarks'] != null) {
        jsonData['Bookmarks'].forEach((postId, postdata) {
          tMyBookmarks.add(postId);
        });

        print("this is tht bookmark list $tMyBookmarks ");
      } else
        print("Got nothing in Bookmarks list  ");

      myBookmarks = tMyBookmarks;

      List<String> tMyPosts = [];

      if (jsonData['myPosts'] != null) {
        jsonData['myPosts'].forEach((postId, postdata) {
          tMyPosts.add(postId);
        });
        print("this is tht myPost list  ");
        print(tMyPosts);
      } else
        print('got nothingin myPosts');

      myPosts = tMyPosts;

      Map<String, dynamic> tMyFollowers = jsonData['folowers'];
      Map<String, dynamic> tMyInfo = jsonData['info'];
      Map<String, dynamic> tVotes = jsonData['votes'];

      myFollowers = tMyFollowers;
      voted = tVotes;
      myInfo = tMyInfo;

      User.imgUrl = myInfo['imageUri'];
      User.myName = myInfo['name'];

      if (myFollowers != null)
        print("this is the myFOllower  $myFollowers");
      else
        print('got nothing in myFollowers');

      if (voted != null)
        print("this is tht Voted $voted ");
      else
        print('got nothing in voted');

      if (myInfo != null)
        print("this is tht Info $myInfo ");
      else
        print('got nothing in myInfo');
    } catch (e) {
      print('The error in reciving Post data on home page');
      print(e);
    }
  }
}
