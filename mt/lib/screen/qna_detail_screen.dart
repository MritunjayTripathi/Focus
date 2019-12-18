import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../models/qna.dart';
import '../models/firebase_constants.dart';
import '../models/user.dart';
import '../screen/profile_stalker_screen.dart';

class QNADetailScreen extends StatefulWidget {
  static final String route = '/qnaDetailScreen';
 // static var ansBack;
  @override
  _QNADetailScreenState createState() => _QNADetailScreenState();
}

class _QNADetailScreenState extends State<QNADetailScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController answerController = TextEditingController();
   // answerController = QNADetailScreen.ansBack;

    final qnaObject = ModalRoute.of(context).settings.arguments as QnAInfo;

    print('QnA Object in qna By QnA detail page page');
    print(qnaObject);

    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final dateOfPost = '20/09/2019';
    // final userOfPost = 'User Name';
    final userImgUrl =
        'https://secure.meetupstatic.com/photos/event/e/6/9/2/600_464159026.jpeg';

    final appBar = AppBar(
      title: Text(
        'Focus',
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
    );

    /*
    Fetch topics
    */

    // final topic1 = 'Data Structure';

    // final topic1chip = Chip(
    //   avatar: CircleAvatar(
    //     child: Text(
    //       topic1.substring(0, 1),
    //       style: TextStyle(
    //           color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
    //     ),
    //     backgroundColor: Colors.white,
    //   ),
    //   backgroundColor: Colors.grey.shade300,
    //   label: Text(
    //     topic1,
    //     style: TextStyle(
    //         fontWeight: FontWeight.bold, color: Colors.black, fontSize: 10),
    //   ),
    // );

    // final topics = [
    //   Padding(
    //     padding: const EdgeInsets.only(right: 4.0),
    //     child: topic1chip,
    //   ),

    // ];

    final hero = GestureDetector(
      onTap: () {
//        Navigator.of(context).pushNamed(ProfileScreen.tag);
      },
      child: CircleAvatar(
        radius: h * 0.028,
        backgroundImage: NetworkImage(
          userImgUrl,
        ),
      ),
    );
    /*
  Fetch User Name and Detail
  */
    final askerUserName = qnaObject.question['askerName'];
    final askerUser = CircleAvatar(
      radius: h * 0.03,
      backgroundImage: NetworkImage(
        userImgUrl,
      ),
    );
    final userContainer = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  right: 16.0, left: 16.0), //bottom: 16.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  askerUserName,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
        // Date Of Post Goes Here... Can Remove below code simply to remove Dat Of Post
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              dateOfPost,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey),
            ),
          ),
        ),
      ],
    );

//****************************************************************
    final questionContainer = ListTile(
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            hero,
            Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                child: RichText(
                  text: TextSpan(
                    text: '',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontSize: 14),
                    children: <TextSpan>[
                      TextSpan(
                        text: qnaObject.question['questionContent'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // subtitle: Wrap(
      //   children: topics,
      // ),
    );

/*
Obtain Comments Here
*/

    final writeAnswer = Flexible(
      //padding: const EdgeInsets.only(top:15.0,),
      child: TextField(
        controller: answerController,
        onChanged: (_) {
         // QNADetailScreen.ansBack = answerController.text;
        },
        minLines: 1,
        maxLines: 15,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: 'write your answer here',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
    final writeAnswerRow = Container(
      width: w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          writeAnswer,
          IconButton(
            tooltip: 'Submit',
            icon: Icon(Icons.send),
            onPressed: () {
              if (answerController.text != '') {
                kFirebaseDbRef
                    .child('qna')
                    .child(qnaObject.qnaId)
                    .child('answers')
                    .push()
                    .set({
                  'answerContent': answerController.text,
                  'answererId': User.userUid,
                  'answererName': User.myName,
                });
              } else
                print('Can\'t post the comment');

              answerController.clear();
              //QNADetailScreen.ansBack='';
            },
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: true,
          left: true,
          right: true,
          top: true,
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                questionContainer,
                Divider(),
                userContainer,
                Divider(),
                writeAnswerRow,
                Divider(),
                AnswersList(qnaObject.qnaId,context),
              ],
            ),
          ),
        ),
      ),
      //bottomNavigationBar: bottomAppBar,
    );
  }
}

class AnswersList extends StatelessWidget {
  // final List<Map<String, String>> answersList;
  // AnswersList(this.answersList);
  String id;
  var ctx;
  AnswersList(this.id,this.ctx);

  Widget chip1(DataSnapshot snapshot, Animation animation, double h) {
    final user1  = GestureDetector(
      onTap: () {
        Navigator.of(ctx).pushNamed(ProfileScreenStalker.route,arguments: snapshot.value['answererId']);
      },
      child:  CircleAvatar(
          radius: h * 0.04,
          backgroundImage: AssetImage('assets/images/dart_bird.png'),
       
        ),
     // ),
    );


    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              width: 2.0,
              style: BorderStyle.solid,
            ),
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                user1,
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, left: 8.0, right: 8.0),
                    child: RichText(
                      text: TextSpan(
                        text: '',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(
                              //Apply the Link
                              text: snapshot.value['answererName']+":  ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          TextSpan(
                            text: snapshot.value['answerContent'],
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget tempWidget=Center(child: CircularProgressIndicator(),);
    return FirebaseAnimatedList(
      defaultChild: tempWidget,
      shrinkWrap: true,
        physics: ClampingScrollPhysics(),
      query: kFirebaseDbRef.child('qna').child(id).child('answers'),
      sort: (a, b) => b.key.compareTo(a.key),
      itemBuilder: (BuildContext ctx, DataSnapshot snapshot,
              Animation<double> animation, int idx) =>
          chip1(snapshot, animation, MediaQuery.of(context).size.height),
    );
    // return Container(
    //   height: 500,
    //   child: ListView.builder(
    //       itemCount: answersList == null ? 0 : answersList.length,
    //       itemBuilder: (ctx, index) {
    //         return chip1(answersList[index],MediaQuery.of(context).size.height);
    //       },
    //     ),
    // );
  }
}

// Widget chip1(Map<String, String> singleAnswer, double h) {
//   final user1 = CircleAvatar(
//     radius: h * 0.04,
//     backgroundImage: NetworkImage(
//       'https://secure.meetupstatic.com/photos/event/e/6/9/2/600_464159026.jpeg',
//     ),
//   );

//   return Column(
//         children:<Widget>[ Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.grey.shade300,
//           width: 2.0,
//           style: BorderStyle.solid,
//         ),
//         color: Colors.grey.shade300,
//         borderRadius: BorderRadius.all(Radius.circular(20.0)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             user1,
//             Flexible(
//               fit: FlexFit.loose,
//               child: Padding(
//                 padding:
//                     const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
//                 child: RichText(
//                   text: TextSpan(
//                     text: '',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w300,
//                         color: Colors.black,
//                         fontSize: 14),
//                     children: <TextSpan>[
//                       TextSpan(
//                         //Apply the Link
//                           text: singleAnswer['answererName'] + ': ',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 14)),
//                       TextSpan(
//                         text: singleAnswer['answerContent'],
//                         style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             color: Colors.black,
//                             fontSize: 14),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//     Divider(),
//         ],
//   );
// }
