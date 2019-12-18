// import 'package:flutter/material.dart';
import '../widgets/upload_image.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import '../models/user.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfileScreen extends StatefulWidget {
  static final String route = '/profileScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final imgUrl =
      'https://www.hawtcelebs.com/wp-content/uploads/2019/04/josephine-langford-for-cosmopolitan-magazine-april-2019-2_thumbnail.jpg';


  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;

    final appBar = AppBar(
      backgroundColor: Colors.lightBlue,
      title: Text(
        'Profile',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );

    final w = MediaQuery.of(context).size.width;
    final h = (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top);
    final hero = GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(UploadImage.route);
      },
      child: Hero(
        tag: 'UserName',
        child: CircleAvatar(
          radius: h * 0.1,
          backgroundImage: NetworkImage(
            UploadImage.currUserImageUri,
          ),
          /*child: Image.network(
                              'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
                              //fit: Boxfit.cover,
                            ),*/
        ),
      ),
    );
    final userName = Text(
      User.myName,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
    final imageNUserName = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        hero,
        SizedBox(
          height: h * 0.02,
        ),
        userName,
      ],
    );
    final card1WithImage = Container(
      width: w,
      height: h * 0.5,
      color: Colors.blue,
      child: Center(
        //padding: const EdgeInsets.all(70.0),
        child: imageNUserName,
      ),
    );
    final emailText = Flexible(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          'sokhal.ravinder7@gmail.comaaaa',
          maxLines: 1,
        ),
      ),
    );
    final rowEmail = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Icon(
            Icons.email,
            size: 32.0,
          ),
        ),
        emailText,
      ],
    );
    /*
    Obtain Interests of User from Database
    */
    final userInterests = Text(
      'Interests',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
    final card2WithEmail =SingleChildScrollView(child: Container(
      height: h*0.6,
      color: Colors.white,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 70.0, left: 0, right: 20, bottom: 20),
        child: Column(
          children: <Widget>[
            rowEmail,
            userInterests,
        
          ],
        ),
      ),
    ),) ;
    /*
  Obtain total no of posts by user
    */
    final noOfPostsByCurrentUser = Text('12',
        style: TextStyle(
          fontSize: 12,
        ));
    final myPostText = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(' My Posts',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        noOfPostsByCurrentUser,
      ],
    );
    /*
  Obtain total upvotes to user
    */
    final totalUpvotesToUser = Text('123',
        style: TextStyle(
          fontSize: 12,
        ));
    final totalUpvotes = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(' Upvotes ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        totalUpvotesToUser,
      ],
    );
    /*
    Obtain / Calculate Users Level according to posts by users and users upvotes
    */
    final levelOfUser = Text('Beginner',
        style: TextStyle(
          fontSize: 12,
        ));
    final levelOfUserText = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(' Level  ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        levelOfUser,
      ],
    );
    final rowOfFloatingCard = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        myPostText,
        totalUpvotes,
        levelOfUserText,
      ],
    );
    final floatingCard = ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Card(
        color: Colors.cyanAccent,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: rowOfFloatingCard,
        ),
      ),
    );

    return Scaffold(
        //backgroundColor: Colors.black,
        appBar: appBar, //*/
        body: SafeArea(
          bottom: true,
          top: true,
          left: true,
          right: true,
          child: SingleChildScrollView(
            child: Container(
              height: h,
              width: w,
              child: Stack(
                //alignment: AlignmentDirectional.topStart, // _alignmentDirectional,
                children: <Widget>[
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    /*child: Column(
                  children: <Widget>[
                    Center(*/
                    child: card1WithImage,
                  ),
                  Positioned(
                    top: h * .5,
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: card2WithEmail,
                  ),
                  //],
                  // ),
                  // ),
                  Positioned(
                    top: h * .42,
                    left: 30.0,
                    right: 30.0,
                    child: floatingCard,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
