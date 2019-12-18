import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/web_post.dart';


class PostsByWeb with ChangeNotifier {
  List<WebPost> webPosts = [];

  List<WebPost> get getPosts {
    return [...webPosts];
  }

  Future<void> fetchData(String  choice) async {
    try {
      var url = 'https://api.github.com/search/topics?q=$choice';

      var data = await http.get(
        Uri.encodeFull(url),
        headers: {'Accept': 'application/vnd.github.mercy-preview+json'},
      );

      print('getting the data from web');

      var jsonBody = json.decode(data.body) as Map<String, dynamic>;

      List<WebPost> _loadedPost = [];
      var jsonItems = jsonBody['items'];

      //  int index=0;

      print("This is the No of posts recieved");
      print(jsonItems.length);

      for (var postdata in jsonItems) {
        WebPost singlePostItem = WebPost(
          title: postdata['display_name'],
          content: postdata['description'],
          byUser: postdata['created_by'],
          tags: postdata['name'],
          dateCreated: postdata['created_at'],
          shortDescription: postdata['short_description'],
        );

        _loadedPost.add(singlePostItem);
      }

      webPosts = _loadedPost;
      notifyListeners();

      print(data.body);
    } catch (e) {
      print('Error While Fetching posts from WEB API');
      print(e);
    }
  }
}
