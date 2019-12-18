import 'package:flutter/material.dart';

class ViewImage extends StatelessWidget {
  static final route = '/view-image-screen';
  static String src = 'https://www.hawtcelebs.com/wp-content/uploads/2019/04/josephine-langford-for-cosmopolitan-magazine-april-2019-2_thumbnail.jpg';
  final body = Center(
        child: Hero(
          tag: 'UserName',
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(src),
            // child: CircleAvatar(
            //   radius: 300.0,
            //   backgroundColor: Colors.transparent,
            //   backgroundImage: NetworkImage(
            //       src),
            // ),
          ),
        ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Profile Pic',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: body,
    );
  }
}
