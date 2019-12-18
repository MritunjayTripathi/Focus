//Last one Tried

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:mt/screen/my_bookmarks.dart';
import 'package:mt/screen/qna_screen.dart';
import 'package:mt/widgets/fetched_from_website.dart';
import 'package:provider/provider.dart';

import '../provider/posts.dart';
import '../widgets/post_item.dart';
import './chat_screen.dart';
import './profile_screen.dart';
import '../models/user.dart';
import '../screen/new_user.dart';
import '../widgets/fetched_from_website.dart';
import '../provider/posts_by_websites.dart';
import '../provider/qna_provider.dart';
import './admin_home_screen.dart';
import './my_posts_screen.dart';
import '../provider/user_provider.dart';

class HomeScreen extends StatefulWidget {
  // const HomeScreen({Key key}) : super(key: key);
  //final Function signOut;
  //HomeScreen(this.signOut);
  static final route = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    print('Inside Home Screen IniIT');
    super.initState();
    //checkAuthentication();

    FirebaseAuth.instance.currentUser().then((user) {
      User.userUid = user.uid;
    });
  }

  void signOut() {
    FirebaseAuth mAuth = FirebaseAuth.instance;
    mAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    //var post = Provider.of<Posts>(context);

    final appBar = AppBar(
      title: Text('Focus'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        )
      ],
    );

    final _kTabPages = <Widget>[
      UsersPost(appBar, context),
      WebPostInHome(appBar, context),
    ];

    final _kTabs = <Tab>[
      Tab(
        icon: Icon(
          Icons.person,
          color: Colors.blue,
        ),
      ),
      Tab(
        icon: Icon(
          Icons.web,
          color: Colors.blue,
        ),
      ),
    ];

    final widthOfDevice = MediaQuery.of(context).size.width;
    //final heightOfDevice = MediaQuery.of(context).size.height;

    return BackdropScaffold(
      title: Text('Focus'),
      iconPosition: BackdropIconPosition.action,
      headerHeight: MediaQuery.of(context).size.height * 0.3,
      frontLayer: Padding(
        padding: const EdgeInsets.only(top: 14),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: TabBar(
              tabs: _kTabs,
            ),
            body: TabBarView(
              children: _kTabPages,
            ),
          ),
        ),
      ),
      backLayer: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            // RaisedButton(
            //   child: Text('Log Out'),
            //   onPressed: signOut,
            // ),

            // RaisedButton(
            //   child: Text('dEMMO1'),
            //   onPressed: () => Navigator.of(context).pushNamed(NewUser.route),
            // ),

            // RaisedButton(
            //   child: Text('qnadata'),
            //   onPressed: () =>
            //       Provider.of<QnA>(context, listen: false).getQnA(),
            // ),

            Option(
                Icons.home, 'My Bookmarks', widthOfDevice, MyBookmarks.route),
            Option(
                Icons.question_answer, 'QNA', widthOfDevice, QnaScreen.route),
            Option(Icons.person_pin, 'Profile', widthOfDevice,
                ProfileScreen.route),
            Option(Icons.message, 'Chats', widthOfDevice, Chat.route),

            Option(
                Icons.person, 'My Posts', widthOfDevice, MyPostsScreen.route),
            Option(Icons.person_pin_circle, 'Admin', widthOfDevice,
                AdminHomeScreen.route),
            OptionFunction(
                Icons.power_settings_new, "Sign Out", widthOfDevice, signOut),
          ],
        ),
      ),
    );
  }
}

//Allignment with width of container as double.infinity
class Option extends StatelessWidget {
  final String optionName;
  final optionIcon;
  final widthOfDevice;
  final route;
  // final String routeName;
  Option(this.optionIcon, this.optionName, this.widthOfDevice, this.route);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          //color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(route),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: widthOfDevice * .1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(optionIcon, color: Colors.amberAccent),
                    SizedBox(
                      width: widthOfDevice * .1,
                    ),
                    Text(
                      optionName,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}

class OptionFunction extends StatelessWidget {
  final String optionName;
  final optionIcon;
  final widthOfDevice;
  final Function function;
  // final String routeName;
  OptionFunction(
      this.optionIcon, this.optionName, this.widthOfDevice, this.function);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          //color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: GestureDetector(
              onTap: function,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: widthOfDevice * .1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(optionIcon, color: Colors.amberAccent),
                    SizedBox(
                      width: widthOfDevice * .1,
                    ),
                    Text(
                      optionName,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}

class UsersPost extends StatefulWidget {
  final appBar;
  final context;
  UsersPost(this.appBar, this.context);

  @override
  _UsersPostState createState() => _UsersPostState();
}

class _UsersPostState extends State<UsersPost> {
  Future<void> reloadPage() {
    //Provider.of<UserProvider>(context).getUserInfo();
    return Provider.of<Posts>(widget.context).getPostInfo();
  }

  static const menuItems = <String>[
    'Date',
    'No of Upvotes',
    'No of Downvotes',
  ];

  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _btnSelectedValue = 'Date';

  @override
  Widget build(BuildContext context) {
    print(this._dropDownMenuItems);


    Widget dropdownBar = ListTile(
      title: Text('Sort By'),
      trailing: DropdownButton<String>(
        items: this._dropDownMenuItems,
        value: _btnSelectedValue,
        onChanged: (String newValue) {
          print('this is the new value in dropdown in home page');
          print(newValue);
          setState(
            () {
              _btnSelectedValue = newValue;
              Provider.of<Posts>(context).sortData(newValue);
            },
          );
        },
      ),
    );

    // return SingleChildScrollView(
    //   //print('Front Laer Of Backdrop'),
    //   child:
    return Column(
      children: <Widget>[
        dropdownBar,
        Container(
          height: MediaQuery.of(context).size.height  -
              widget.appBar.preferredSize.height -
              MediaQuery.of(context).padding.top-MediaQuery.of(context).size.height*0.2,
          child: RefreshIndicator(
            onRefresh: reloadPage,
            child: PostItem(),
          ),
          decoration: BoxDecoration(
              //image: DecorationImage(image: AssetImage('assets/images/dart_bird.png'),),
              // gradient: LinearGradient(
              //   begin: Alignment.bottomLeft,
              //   end: Alignment.topRight,
              //   stops: [0.1,0.5,0.7,0.9],
              //   colors: [
              //     Colors.purple[800],
              //     Colors.indigo[700],
              //     Colors.blue[500],
              //     Colors.blue[400],
              //   ]
              color: Colors.grey.shade100
              //),
              ),
        ),
      ],
    );
    //);
  }
}

class WebPostInHome extends StatefulWidget {
  final appBar;
  final context;
  WebPostInHome(this.appBar, this.context);

  static const menuItems = <String>[
    'Java',
    'C',
    'C++'
  ];

  @override
  _WebPostInHomeState createState() => _WebPostInHomeState();
}

class _WebPostInHomeState extends State<WebPostInHome> {
  Future<void> reloadPage() {
    _btnSelectedValue='Java';
    return Provider.of<PostsByWeb>(widget.context).fetchData('Java');
    
  }

  final List<DropdownMenuItem<String>> _dropDownMenuItems = WebPostInHome.menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _btnSelectedValue = 'Java';

  @override
  Widget build(BuildContext context) {


      Widget dropdownBar = ListTile(
      title: Text('Get Info About'),
      trailing: DropdownButton<String>(
        items: this._dropDownMenuItems,
        value: _btnSelectedValue,
        onChanged: (String newValue) {
          print('this is the new value in dropdown in home page');
          print(newValue);
          setState(
            () {
              _btnSelectedValue = newValue;
              Provider.of<PostsByWeb>(context).fetchData(newValue);
            },
          );
        },
      ),
    );


     return Column(
      children: <Widget>[
        dropdownBar,
        Container(
          height: MediaQuery.of(context).size.height * 0.75 -
              widget.appBar.preferredSize.height -
              MediaQuery.of(context).padding.top,
          child: RefreshIndicator(
            onRefresh: reloadPage,
            child: FetchedFromWebsite(),
          ),
          decoration: BoxDecoration(
       
              color: Colors.grey.shade100
         
              ),
        ),
      ],
    );
    
    // return Container(
    //   height: MediaQuery.of(context).size.height -
    //       widget.appBar.preferredSize.height -
    //       MediaQuery.of(context).padding.top,
    //   child: RefreshIndicator(
    //     onRefresh: reloadPage,
    //     child: FetchedFromWebsite(),
    //   ),
  
    // );
    //);
  }
}




  // gradient: LinearGradient(
  //           begin: Alignment.bottomLeft,
  //           end: Alignment.topRight,
  //           stops: [
  //             0.1,
  //             0.4,
  //             0.7,
  //             0.9
  //           ],
  //           colors: [
  //             Colors.purple[500],
  //             Colors.indigo[400],
  //             Colors.blue[300],
  //             Colors.blue[200],
  //           ]),