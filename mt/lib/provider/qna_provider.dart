import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import '../models/post.dart';
import '../models/qna.dart';

class QnA with ChangeNotifier {
//Getiing posts in chunk for future builder without fetchin comments data

 
  List<QnAInfo>allQnAList=[];

  
  
  List<QnAInfo> get getAllQnAList {
    return [...allQnAList];
  }


  
  // List<Map<String,String>> get getAnswers {
  //   return [...answers];
  // }

  
  Future<void> getQnA() async {
    const url = 'https://focus-bbca0.firebaseio.com/qna.json';

    try {
      var data = await http.get(url);
      var jsonData = json.decode(data.body) as Map<String, dynamic>;

      print(jsonData);

      
      List<QnAInfo> loadedqna = [];
      //Populating posts in chunk
  print('z');
      jsonData.forEach((postId, postdata){
        //loadedqna.add(postdata);
        List<Map<String,String>> temp=[];
        print('a');
        Map<String,dynamic> temp1=postdata['answers'];
        print('b');
        temp1.forEach((answerId,answerData){
          print(answerData);
          print(answerData.runtimeType.toString());
          print(answerData['answerContent']);
          print(answerData['answererId']);
          print(answerData['answererName']);
          temp.add({
            'answerContent':answerData['answerContent'],
            'answererId':answerData['answererId'],
            'answererName':answerData['answererName'],
          });
        });
        print('c');
          Map<String,String> question={
            'askerName':postdata['question']['askerName'],
            'questionContent':postdata['question']['questionContent'],
          };
          print(question);
          print('d');

          String topic=postdata['topic'];
          print('e');
          loadedqna.add(QnAInfo(answers: temp,question: question,topic: topic,qnaId: postId));
          print('f');
          print('This is the qna Id listen to me morty plzz $postId');
      });

      allQnAList=loadedqna;
      print('This is the qna List recieved');
      print(allQnAList[0].answers);
    } catch (e) {
      print('The error in reciving Post data on QnA');
      print(e);
    }
  }
}
