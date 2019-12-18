import 'package:flutter/foundation.dart';

class WebPost {
  final String title;
  final String content;  
  final String shortDescription; //
  final String byUser;
  final String tags; 
  final String dateCreated; //

  WebPost({
    this.byUser,
    @required this.content,
     this.tags,
    @required this.title,
    this.dateCreated,
    this.shortDescription,
  });
}


//for loop in posts array 