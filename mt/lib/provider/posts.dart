import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mt/models/firebase_constants.dart';
import 'dart:convert';
import '../models/user.dart';

import '../models/post.dart';

class Posts with ChangeNotifier {
//Getiing posts in chunk for future builder without fetchin comments data

  List<PostInfo> postList = [];
  List<PostInfo> myPostList = [];

  List<PostInfo> postListSoretedByDate = [];
  List<PostInfo> postListSortedByUpvote = [];
  List<PostInfo> postListSortedByDownVote = [];

  List<PostInfo> get getPosts {
    return [...postList];
  }

  List<PostInfo> get getMyPosts {
    return [...myPostList];
  }

  void deletePost(String id) {
    kFirebaseDbRef.child('post').child(id).remove();
    kFirebaseDbRef
        .child('users')
        .child(User.userUid)
        .child('myPosts')
        .child(id)
        .remove();
    myPostList.removeWhere((myPsot) {
      return myPsot.postId == id; 
    });
    notifyListeners();
  }

  void populateMyPostList(List<String> myPostIdList) {
     List<PostInfo> tMyPostList = [];
    if (myPostIdList == null) return;
    for (String id in myPostIdList) {
      tMyPostList.add(postList.firstWhere((post) => post.postId == id));
    }
    myPostList=tMyPostList;
  }



    
  Future<void> updatePost(Map<String,String> info) async {
    print("Inside Updating My Post");
    print(info['title']);
    print(info['content']);
    print(info['tag']);
    // const url = 'https://focus-bbca0.firebaseio.com/post.json';
    // try {
    //   final response = await http.post(
    //     url,
    //     body: json.encode({
    //       'title': userPost.title,
    //       'content': userPost.content,
    //       'tags': userPost.tags==null||userPost.tags==''?'Data Structure':userPost.tags,
    //       'byUser': User.myName,
    //       'noOfUpvotes': userPost.noOfUpvotes,
    //       'noOfDownvotes': userPost.noOfDownVotes,
    //       'userImage': User.imgUrl,
    //     }),
    //   );
    //   final newPost = PostInfo(
    //     postId: json.decode(response.body)['name'],
    //     byUser: User.myName,
    //     title: userPost.title,
    //     content: userPost.content,
    //     userImage: User.imgUrl,
    //     tags: userPost.tags,
    //     noOfDownVotes: userPost.noOfDownVotes,
    //     noOfUpvotes: userPost.noOfUpvotes,
    //   );

    

    //   notifyListeners();
    // } catch (error) {
    //   print(error);
    //   throw error;
    // }
    // notifyListeners();
    //then((response){

    //  }).catchError((error){
    //    throw error;
    //  });
  }












  Future<void> addPost(PostInfo userPost) async {
    print(userPost.toString());
    print(userPost.byUser);
    print(userPost.content);
    if(userPost.tags==null)
    //userPost.tags='Data structure';
    print(userPost.tags);
    print(userPost.noOfUpvotes);
    print(userPost.noOfDownVotes);
    print(userPost.title);
    print(userPost.userImage);

    const url = 'https://focus-bbca0.firebaseio.com/pendingPost.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': userPost.title,
          'content': userPost.content,
          'tags': userPost.tags==null||userPost.tags==''?'Data Structure':userPost.tags,
          'byUser': User.myName,
          'noOfUpvotes': userPost.noOfUpvotes,
          'noOfDownvotes': userPost.noOfDownVotes,
          'userImage': User.imgUrl,
        }),
      );
      final newPost = PostInfo(
        postId: json.decode(response.body)['name'],
        byUser: User.myName,
        title: userPost.title,
        content: userPost.content,
        userImage: User.imgUrl,
        tags: userPost.tags,
        noOfDownVotes: userPost.noOfDownVotes,
        noOfUpvotes: userPost.noOfUpvotes,
      );

      kFirebaseDbRef
          .child('users')
          .child(User.userUid)
          .child('myPosts')
          .child(newPost.postId)
          .set(1);
     
      myPostList.add(newPost);
   

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
    notifyListeners();
    //then((response){

    //  }).catchError((error){
    //    throw error;
    //  });
  }

  List<PostInfo> getMyBookmarksList(List<String> myBookmarksIdList) {
    List<PostInfo> myBookmarksList = [];

    for (String id in myBookmarksIdList) {
      myBookmarksList.add(postList.firstWhere((post) => post.postId == id));
    }

    //for(PostInfo ob in myBookmarksList)
    //{
    //if(ob==null)
    print('yes');
    print(myBookmarksList);
    //myBookmarksList.remove((p)=>p==null);
    //}
    //list.firstWhere((element) => a == b, orElse: () => print('No matching element.'));

    return myBookmarksList;
  }

  void sortData(String sortBy) {
    if (sortBy == 'Date')
      postList = postListSoretedByDate;
    else if (sortBy == 'No of Upvotes')
      postList = postListSortedByUpvote;
    else if (sortBy == 'No of Downvotes') postList = postListSortedByDownVote;

    notifyListeners();
  }

  Future<void> getPostInfo() async {
    const url = 'https://focus-bbca0.firebaseio.com/post.json';

    try {
      var data = await http.get(url);
      var jsonData = json.decode(data.body) as Map<String, dynamic>;

      print(jsonData);

      List<PostInfo> loadedPost = [];
      //Populating posts in chunk

      jsonData.forEach((postId, postdata) {
        PostInfo singlePostItem = PostInfo(
            title: postdata['title'],
            content: postdata['content'],
            byUser: postdata['byUser'],
            tags: postdata['tags'],
            postId: postId,
            noOfUpvotes: postdata['noOfUpvotes'],
            noOfDownVotes: postdata['noOfDownvotes'],
            userImage: postdata['userImage']);
        loadedPost.add(singlePostItem);
      });

      postListSoretedByDate = [...loadedPost]; //.reversed.toList();
      postList = postListSoretedByDate.reversed.toList();

      postListSortedByDownVote = [...loadedPost];
      postListSortedByUpvote = [...loadedPost];

      postListSortedByDownVote
          .sort((a, b) => a.noOfDownVotes.compareTo(b.noOfDownVotes));
      postListSortedByDownVote = postListSortedByDownVote.reversed.toList();

      postListSortedByUpvote
          .sort((a, b) => a.noOfUpvotes.compareTo(b.noOfUpvotes));
      postListSortedByUpvote = postListSortedByUpvote.reversed.toList();

      print('date');
      print(
          '${postListSoretedByDate[0].byUser} and ${postListSoretedByDate[1].byUser} and${postListSoretedByDate[2].byUser}');
      print('upvote');
      print(
          '${postListSortedByUpvote[0].noOfUpvotes} and ${postListSortedByUpvote[1].noOfUpvotes} and ${postListSortedByUpvote[2].noOfUpvotes}');
      print('downvote');
      print(
          '${postListSortedByDownVote[0].noOfDownVotes} and ${postListSortedByDownVote[1].noOfDownVotes} and ${postListSortedByDownVote[2].noOfDownVotes}');

      notifyListeners();
      print('notified');
    } catch (e) {
      print('The error in reciving Post data on home page');
      print(e);
    }
  }
}
