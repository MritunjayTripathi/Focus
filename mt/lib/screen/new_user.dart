import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mt/models/user.dart';

import '../models/firebase_constants.dart';
import '../screen/home_screen.dart';
List<String> selectedTopics = [];

class NewUser extends StatefulWidget {
  
  static String name;
  static String phoneNO;

  static final route = '/new-user';

  static const pages = [
    BasicDetails(),
    TopicChoices(),
    WelcomePage(),
  ];

  const NewUser({Key key}) : super(key: key);

  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    _controller = new TabController(length: 3,initialIndex: 0,vsync: this);//DefaultTabController.of(context);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DefaultTabController(
      
        length: 3,
        child: Builder(
          builder: (BuildContext context) => Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  //Main Ui
                  child: TabBarView(
                    controller: _controller,
                    //Consider this Again
                    physics: NeverScrollableScrollPhysics(),
                    children: NewUser.pages,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: TabPageSelector(controller: _controller,),
                    ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //_controller.animateTo((_controller.index+1)%3);

          if (!_controller.indexIsChanging) {
            if (_controller.index == 0) {
              print("Pressed floating button in First Page");
              print(NewUser.name);
              print(NewUser.phoneNO);
              kFirebaseDbRef
                  .child('users')
                  .child(User.userUid)
                  .child('info')
                  .update({'name': NewUser.name});

              _controller.animateTo(_controller.index + 1);
            } else if (_controller.index == 1) {

              Map<String,String> tempMap={};
              for(String topic  in selectedTopics)
              {
                tempMap[topic]='1';
              }
              print(tempMap);
              print("Pressed floating button in Second Page");
              kFirebaseDbRef
                  .child('users')
                  .child(User.userUid)
                  .child('interest')
                  .set(tempMap);

              _controller.animateTo(_controller.index + 1);
            } else if (_controller.index == 2) {
              print("Pressed floating button in Third Page");
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context){return HomeScreen();}
              ));
            }
          }
        },
        child: Icon(Icons.arrow_right),
      ),
    );
  }
}

class BasicDetails extends StatefulWidget {
  const BasicDetails({Key key}) : super(key: key);
  @override
  _BasicDetailsState createState() => _BasicDetailsState();
}

class _BasicDetailsState extends State<BasicDetails> {
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      new GlobalKey<FormFieldState<String>>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  String _validateName(String value) {
    if (value.isEmpty) return 'Name is Required.';
    final RegExp nameExp = new RegExp(r'^[A-Za-z]+$');
    if (!nameExp.hasMatch(value))
      return 'Please Enter only Alphabetical characters.';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Center(
              child: Text(
                'Welcome',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
                icon: Icon(Icons.person),
                hintText: 'What do pepole call you?',
                labelText: 'Name *',
              ),
              onEditingComplete: (){
                
                NewUser.name = nameController.text;

              },
              onChanged: (String value) {
                NewUser.name = nameController.text;
                print(value);
                print(nameController.text);
                print("Good");

              },
             // validator: _validateName,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextFormField(
          //     controller: phoneNoController,
          //     //textCapitalization: TextCapitalization.words,
          //     decoration: InputDecoration(
          //       border: UnderlineInputBorder(),
          //       filled: true,
          //       icon: Icon(Icons.phone),
          //       hintText: 'Please provide your contact No !',
          //       labelText: 'Phone No *',
          //       prefixText: '+91',
          //     ),

          //     keyboardType: TextInputType.phone,
          //     onSaved: (String value) {
          //       NewUser.phoneNO = value;
          //     },
          //     inputFormatters: <TextInputFormatter>[
          //       WhitelistingTextInputFormatter.digitsOnly,
          //     ],
          //   ),
          // ),
          Divider(),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 8.0),
          //   child: Container(
          //     margin: EdgeInsets.symmetric(horizontal: 52),
          //     color: Colors.blue,
          //     child: FlatButton(
          //       //focusColor: Colors.red,
          //       //color: Colors.deepOrange,
          //       onPressed: null,
          //       child: Text(
          //         'Upload Your Profile Picture',
          //         style: TextStyle(color: Colors.white),
          //       ),
          //     ),
          //   ),
          // ),
          Divider(),
        ],
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bird =
        'https://spng.pngfly.com/20180710/hul/kisspng-dart-programming-language-flutter-object-oriented-flutter-logo-5b454ed38607c1.934218061531268819549.jpg';
    final fImg =
        'https://flutterappdev.com/wp-content/uploads/2019/01/Screen-Shot-2019-01-25-at-12.54.42-PM.png';
    /*
        We have to implement different view for land scape
        */
    //return SingleChildScrollView(
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            fImg,
            height: 150,
          ),
          //Divider(),
          Padding(
            padding: EdgeInsets.only(
                top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
            child: Text(
              'You are good to begin',
              style: TextStyle(
                  backgroundColor: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            'Happy Learning !',
            style: TextStyle(
                backgroundColor: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          //Happy Learning !
        ],
      ),
    );
  }
}

class TopicChoices extends StatefulWidget {
  const TopicChoices({Key key}) : super(key: key);

  @override
  _TopicChoicesState createState() => _TopicChoicesState();
}

class _TopicChoicesState extends State<TopicChoices> {
  final List<String> _choices = [
    "CSS",
    "JAVA",
    "Flutter",
    "Android",
  ];

  final List<String> _choiceImages = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXHdXVEzTkfjEjSna7epR0ufYzx5DrTnpebbBm7PIcXO6a9-MY",
    "https://www.oracle.com/a/ocom/img/hp11-intl-java-logo.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2uUCCMYIkg7tp24Tu3Sw4I0A5L91PPJFCOEm02ZGWDJSr7Cj7sA",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNaoKBjKXE6TQeZ_El_D5v1pM7Yj2hwMbYC2ebg8wOI7IefDHA",
  ];

  @override
  Widget build(BuildContext context) {
    Widget gridViewSelection = GridView.count(
      childAspectRatio: 1.5,
      crossAxisCount: 2,
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 20,
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      children: _choices.map((choice) {
        return GestureDetector(
          onTap: () {
            // _selectedIcons.clear();

            setState(() {
              if (selectedTopics.contains(choice)) {
                selectedTopics.remove(choice);
              } else {
                selectedTopics.add(choice);

                print(selectedTopics);
              }
            });
          },
          child: GridViewItem(_choiceImages[_choices.indexOf(choice)],
              selectedTopics.contains(choice)),
        );
      }).toList(),
    );
    return gridViewSelection;
  }

  //code on selected iconData
}

class GridViewItem extends StatelessWidget {
  final String _choice;
  final bool _isSelected;

  GridViewItem(this._choice, this._isSelected);

  @override
  Widget build(BuildContext context) {
    print(_choice);
    print(_isSelected);
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: _isSelected ? .9 : 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              color: _isSelected ? Colors.blue.withOpacity(.7) : Colors.blue,
              child: GridTile(
                child: Center(
                  child: Image.network(
                    _choice,
                    fit: BoxFit.fill,
                  ), /* Text(
                  _choice,
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)
                  // color: Colors.white,
                ),*/
                ),
                // shape: CircleBorder(),
                //fillColor: _isSelected ? Colors.blue : Colors.green,
              ),
            ),
          ),
        ),
        _isSelected
            ? ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  color: Colors.black38,
                  child: Center(
                    child: Icon(
                      Icons.check_circle_outline,
                      size: 40,
                      color: Colors.white70,
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
