import 'package:flutter/foundation.dart';

class QnAInfo {
  Map<String, String> question;
  List<Map<String, String>> answers;
  String topic;
  String qnaId;

  QnAInfo({
    @required this.question,
    @required this.answers,
    @required this.topic,
    @required this.qnaId
  });
}

// Map<String,String> question={
//   'askerName':postdata['askerName'],
//   'questionContent':postdata['questionContent'],
// };

// temp.add({
//             'answerContent':answerData['answerContent'],
//             'answererId':answerData['answererId'],
//             'answererName':answerData['answererName'],
//           });
