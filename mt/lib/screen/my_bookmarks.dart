import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/post_tile_simple.dart';
import '../provider/user_provider.dart';
import '../provider/posts.dart';
import '../models/post.dart';

class MyBookmarks extends StatefulWidget {
  static final route = '/my-bookmarks';

  @override
  _MyBookmarksState createState() => _MyBookmarksState();
}

class _MyBookmarksState extends State<MyBookmarks> {
  List<String> myBookmarksIdList;
  List<PostInfo> myBookmarksList;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    
    myBookmarksIdList =
        Provider.of<UserProvider>(context).getMyBookmarksIdList;
    myBookmarksList = Provider.of<Posts>(context)
        .getMyBookmarksList(myBookmarksIdList);
        
    final appbar = AppBar(
      title: Text('My Bookmarks'),
    );
    final heightOfDevice = MediaQuery.of(context).size.height;
    //final widthOfDevice=MediaQuery.of(context).size.width;
    final heightOfAppbar = appbar.preferredSize.height;
    return Scaffold(
      appBar: appbar,
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          children: <Widget>[
            Align(
              heightFactor: 2,
              alignment: Alignment.topCenter,
              child: Text(
                'Total No Of Bookmarks : ${myBookmarksList.length}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: heightOfDevice -
                  heightOfAppbar -
                  MediaQuery.of(context).padding.top -
                  18 * 4,
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return //Card(
                      //child:
                      Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Card(
                      elevation: 2.5,
                      child: PostTileSimple(myBookmarksList[index]),
                    ),
                  );

                  //);
                },
                itemCount: myBookmarksList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
