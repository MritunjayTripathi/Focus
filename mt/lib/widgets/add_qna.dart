import 'package:flutter/material.dart';
import 'package:mt/models/user.dart';

import '../models/firebase_constants.dart';

class AddQna extends StatelessWidget {
  static final String route = '/add-qna';
  @override
  Widget build(BuildContext context) {
    TextEditingController addQController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Question'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TextField(
            controller: addQController,
          ),
          Divider(),
          RaisedButton(
            child: Text('Add'),
            onPressed: () {
              kFirebaseDbRef.child('qna').push().set({
                'question': {
                  'askerName': User.myName,
                  'questionContent': addQController.text
                },
                'topic': "No Topic",
                'answers': {
                  'answer1': {
                    'answerContent': 'Write th First Ans here..',
                    'answererId': '11',
                    'answererName': 'Admin',
                  }
                },
                //'answers':{},
              });
            },
          )
        ],
      ),
    );
  }
}
