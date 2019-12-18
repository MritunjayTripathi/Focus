import 'package:flutter/material.dart';
import 'package:mt/screen/my_bookmarks.dart';
import 'package:mt/screen/profile_stalker_screen.dart';
import 'package:mt/widgets/add_qna.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './provider/posts_by_websites.dart';
import './screen/post_detail_screen.dart';
import './provider/posts.dart';
import './screen/auth-screen.dart';
import './screen/profile_screen.dart';
import './provider/auth.dart';
import './screen/home_screen.dart';
import './widgets/view_image.dart';
import './screen/chat_screen.dart';
import './models/user.dart';
import './screen/new_user.dart';
import './screen/my_bookmarks.dart';
import './screen/post_detail_from_web_screen.dart';
import './screen/qna_screen.dart';
import './provider/user_provider.dart';
import './provider/qna_provider.dart';
import './screen/qna_detail_screen.dart';
import './widgets/upload_image.dart';
import './screen/my_posts_screen.dart';
import './widgets/create_new_post.dart';
import './screen/edit_my_post.dart';
import './screen/admin_home_screen.dart';
import './widgets/add_qna.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Posts(),
        ),
        ChangeNotifierProvider.value(
          value: PostsByWeb(),
        ),
        ChangeNotifierProvider.value(
          value: UserProvider(),
        ),
        ChangeNotifierProvider.value(
          value: QnA(),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            // accentColor: Colors.amber,
            //errorColor: Colors.red,
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  button: TextStyle(color: Colors.white),
                ),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
          ),
          routes: {
            HomeScreen.route: (ctx) => HomeScreen(),
            ProfileScreen.route: (ctx) => ProfileScreen(),
            ViewImage.route: (ctx) => ViewImage(),
            PostDetailScreen.route: (ctx) => PostDetailScreen(),
            Chat.route: (ctx) => Chat(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
            NewUser.route: (ctx) => NewUser(),
            MyBookmarks.route: (ctx) => MyBookmarks(),
            PostDetailFromWebScreen.route: (ctx) => PostDetailFromWebScreen(),
            QnaScreen.route: (ctx) => QnaScreen(),
            QNADetailScreen.route: (ctx) => QNADetailScreen(),
            UploadImage.route:(ctx) =>UploadImage(),
            MyPostsScreen.route:(ctx) => MyPostsScreen(),
            CreateNewPost.route:(ctx) => CreateNewPost(),
            ProfileScreenStalker.route: (ctx) => ProfileScreenStalker(),
            EditMyPost.route:(ctx) => EditMyPost(),
            AdminHomeScreen.route: (ctx) =>AdminHomeScreen(),
            // ProfileScreenStalker.route: (ctx) => ProfileScreenStalker(),
            // UploadImage.route: (ctx) => UploadImage(),
            AddQna.route: (ctx) => AddQna(),

            // FetchedFromWebsite.route : (ctx) =>FetchedFromWebsite(),
          },
          home: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  bool isLoading = true;

  checkAuthentication() async {
    print('Checking Authentication in Main.dart');
    _auth.onAuthStateChanged.listen((user) {
      if (user == null) {
        print('user is Null');
        Navigator.pushReplacementNamed(context, AuthScreen.routeName);
      }
    });
  }

  getUser() async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    await firebaseUser?.reload();
    firebaseUser = await _auth.currentUser();
    print('Trying to get user in main.dart');
    if (firebaseUser != null) {
      setState(() {
        print('We Got the User');
        this._user = firebaseUser;
        User.userUid = this._user.uid;
        
        this.isLoading = false;
      });
    }
    print(this._user);
  }

  @override
  void initState() {
    super.initState();

    checkAuthentication();
    getUser();
    Provider.of<QnA>(context, listen: false).getQnA();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : HomeScreen(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:mt/screen/my_bookmarks.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:splashscreen/splashscreen.dart';

// import './provider/posts_by_websites.dart';
// import './screen/post_detail_screen.dart';
// import './provider/posts.dart';
// import './screen/auth-screen.dart';
// import './screen/profile_screen.dart';
// import './provider/auth.dart';
// import './screen/home_screen.dart';
// import './widgets/view_image.dart';
// import './screen/chat_screen.dart';
// import './models/user.dart';
// import './screen/new_user.dart';
// import './screen/my_bookmarks.dart';
// import './screen/post_detail_from_web_screen.dart';
// import './screen/qna_screen.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider.value(
//           value: Auth(),
//         ),
//         ChangeNotifierProvider.value(
//           value: Posts(),
//         ),
//         ChangeNotifierProvider.value(
//           value: PostsByWeb(),
//         ),
//       ],
//       child: Consumer<Auth>(
//         builder: (ctx, auth, _) => MaterialApp(
//           title: 'Flutter Demo',
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//             // accentColor: Colors.amber,
//             //errorColor: Colors.red,
//             fontFamily: 'Quicksand',
//             textTheme: ThemeData.light().textTheme.copyWith(
//                   title: TextStyle(
//                     fontFamily: 'OpenSans',
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                   button: TextStyle(color: Colors.white),
//                 ),
//             appBarTheme: AppBarTheme(
//               textTheme: ThemeData.light().textTheme.copyWith(
//                     title: TextStyle(
//                       fontFamily: 'OpenSans',
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//             ),
//           ),
//           routes: {
//             HomeScreen.route: (ctx) => HomeScreen(),
//             ProfileScreen.route: (ctx) => ProfileScreen(),
//             ViewImage.route: (ctx) => ViewImage(),
//             PostDetailScreen.route: (ctx) => PostDetailScreen(),
//             Chat.route: (ctx) => Chat(),
//             AuthScreen.routeName: (ctx) => AuthScreen(),
//             NewUser.route: (ctx) => NewUser(),
//             MyBookmarks.route: (ctx) => MyBookmarks(),
//             PostDetailFromWebScreen.route :(ctx) => PostDetailFromWebScreen(),
//             QnaScreen.route:(ctx) => QnaScreen(),
//            // FetchedFromWebsite.route : (ctx) =>FetchedFromWebsite(),
//           },
//           home: MyHomePage(),
//         ),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   FirebaseUser _user;
//   bool isLoading = true;

//   checkAuthentication() async {
//     print('Checking Authentication in Main.dart');
//     _auth.onAuthStateChanged.listen((user) {
//       if (user == null) {
//         print('user is Null');
//         Navigator.pushReplacementNamed(context, AuthScreen.routeName);
//       }
//     });
//   }

//   getUser() async {
//     FirebaseUser firebaseUser = await _auth.currentUser();
//     await firebaseUser?.reload();
//     firebaseUser = await _auth.currentUser();
//     print('Trying to get user in main.dart');
//     if (firebaseUser != null) {
//       setState(() {
//         print('We Got the User');
//         this._user = firebaseUser;
//         User.userUid = this._user.uid;

//         this.isLoading = true;
//       });
//     }
//     print(this._user);
//   }

//   @override
//   void initState() {
//     super.initState();

//     checkAuthentication();
//     getUser();

//   }

//   Widget build(BuildContext context) {
//     return SplashScreen(
//       loadingText: Text('Hii Bhaiya Mujhse Galti Ho gyi',style: TextStyle(color: Colors.white),),
//       loaderColor: Colors.white,
//       backgroundColor: Colors.black87,

//       title: Text('FOCUS',style: TextStyle(color: Colors.white),),
//       image: Image.network('https://res.cloudinary.com/teepublic/image/private/s--T33qW81Q--/t_Preview/b_rgb:191919,c_lpad,f_jpg,h_630,q_90,w_1200/v1543422305/production/designs/3601139_0.jpg'),
//       seconds: 5,
//       photoSize: 150,
//       navigateAfterSeconds:  Scaffold(
//         body: !isLoading
//             ? Container(
//                 child: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               )
//             :HomeScreen(),
//       ),
//     );
//   }
// }
