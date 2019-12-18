import 'package:flutter/foundation.dart';

class PostInfo {
  final String title;
  final String content;
  final String byUser;
  final String tags;
  final String postId;
  final noOfUpvotes;
  final noOfDownVotes;
  final userImage;

  PostInfo({
    @required this.byUser,
    @required this.content,
    @required this.tags,
    @required this.title,
    @required this.postId,
    @required this.noOfUpvotes,
    @required this.noOfDownVotes,
    @required this.userImage,
  });
}
