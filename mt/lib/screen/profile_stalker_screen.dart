import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mt/models/firebase_constants.dart';
import 'package:mt/screen/auth-screen.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';
import './temp_profile_screen.dart';
import '../widgets/view_image.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
class ProfileScreenStalker extends StatefulWidget {


  static String userName="User Name";
  
  static String imageUri="#";
  static String usersPost="0";
  static String usersUpvotes="0";
  static String usersLevel="Beginner";
  static int tempFlag=0;
  

  ProfileScreenStalker();


  static final String route = '/ProfileScreenStalker';

  @override
  _ProfileScreenStalkerState createState() => _ProfileScreenStalkerState();
}

class _ProfileScreenStalkerState extends State<ProfileScreenStalker> {


Map<String,String> userInfo={};
var userId;
String imageUrl='#';
String username = 'User Name';
String userUpvotes = '0';
int flag = 0;
int button=1;

void followUser(String userId){
  kFirebaseDbRef.child('users').child(User.userUid).child('folowers').push().set(userId);
  setState(() {
   button=2; 
  });
}

 void getUserInfo(String id) async
  {
     var url = 'https://focus-bbca0.firebaseio.com/users/$id/info.json';
     print(id);
        //ProfileScreenStalker.imageUri="#";
        // ProfileScreenStalker.usersPost="";
        // ProfileScreenStalker.usersUpvotes="0";
        // ProfileScreenStalker.usersLevel="Beginner";

    try {
      var data = await http.get(url);
      var jsonData = json.decode(data.body) as Map<String, dynamic>;
      if((jsonData!=null)&& (flag!=1))
      {
        ProfileScreenStalker.tempFlag=1;
        setState(() {
        // ProfileScreenStalker.imageUri="#";
        // ProfileScreenStalker.usersPost="";
        // ProfileScreenStalker.usersUpvotes="0";
        // ProfileScreenStalker.usersLevel="Beginner";
        imageUrl=jsonData['imageUri']==null?"#":jsonData['imageUri'];
        username=jsonData['name']==null?"":jsonData['name'];
        userUpvotes=jsonData['noOfUpvotes']==null?"0":jsonData['noOfUpvotes'].toString();
        flag = 1;
      
        });

        print('I did set the data');
        
      
      }
      print('I got this User info After stalking ');
      print(jsonData);
    }catch(e){
        print('this is some error in stalking');
        print(e);
    }

  }


  @override
  void initState() {
         
   super.initState();
  }

 

  final imgUrl =ProfileScreenStalker.imageUri=="#"?
      'https://www.hawtcelebs.com/wp-content/uploads/2019/04/josephine-langford-for-cosmopolitan-magazine-april-2019-2_thumbnail.jpg'
      :   ProfileScreenStalker.imageUri
      ;

  @override
  Widget build(BuildContext context) {
    
        userId = ModalRoute.of(context).settings.arguments as String;
      getUserInfo(userId);
  
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
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
        final hero = GestureDetector(
      onTap: () {
        /**************************************************************************************************/
        //if(user == Stalker)
        Navigator.of(context).pushNamed(ViewImage.route,);
        //else
        //Navigator.of(context).pushNamed(UploadImage.route);
        /*************************************************************************************************/
      },
      child: Hero(
        tag: 'UserName',
        child: CircleAvatar(
          radius: h * 0.1,
          backgroundImage: imageUrl=="#"?
      AssetImage('assets/images/dart_bird.png')
      :   NetworkImage(
            imageUrl,
          ),
      
        
          /*child: Image.network(
                              'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
                              //fit: Boxfit.cover,
                            ),*/
        ),
      ),
    );
    final userName = Text(
      username,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
    var followText = button==1?'Follow':'Following';
    final imageNUserName = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        hero,
        SizedBox(
          height: h * 0.02,
        ),
        userName,
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          child: FlatButton(
            color: Colors.blue.shade500,
            hoverColor: Colors.pink,
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                followText,
                style: TextStyle(color: Colors.white, fontSize: 20,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: button==1? Icon(Icons.person_add,color: Colors.white,):Icon(Icons.person,color: Colors.white,),
              )
            ],
            ),
            onPressed: () {

              followUser(userId);
              //*********** Make follow to Following *****************//
              
            },
          ),
        ),
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
    final card2WithEmail = SingleChildScrollView(
      child: Container(
        width: w,
        height: h * .6,
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
      ),
    );
    /*
  Obtain total no of posts by user
    */
    final noOfPostsByCurrentUser = Text(ProfileScreenStalker.usersPost,
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
    final totalUpvotesToUser = Text(userUpvotes,
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
    final levelOfUser = Text(ProfileScreenStalker.usersLevel,
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
