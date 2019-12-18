import 'package:flutter/material.dart';

class SentMsgUI extends StatelessWidget {
  final String currUserName;
  final String currUserImgUrl;
  final String sendMsg;

  SentMsgUI({
    this.currUserName,
    this.currUserImgUrl,
    this.sendMsg,
  });

  // List<Widget> getSentMessageLayout() {
  //   return <Widget>[
  //           Expanded(
  //             child: Container(
  //                 width: MediaQuery.of(context).size.width*0.79,
  //                 decoration: BoxDecoration(
  //                       border: Border.all(
  //                       color: Colors.grey.shade300,
  //                       width: 1.0,
  //                       style: BorderStyle.solid,
  //                   ),
  //                   color: Colors.grey.shade300,
  //                   borderRadius: BorderRadius.all(Radius.circular(20.0)),
  //                 ),
  //                child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: <Widget>[
  //                 Text(currUserName, style: Theme.of(context).textTheme.subhead),
  //                 Text(
  //                   'time',
  //                   //DateTime.fromMillisecondsSinceEpoch(sentTime).toString(),
  //                   style: Theme.of(context).textTheme.caption,
  //                 ),
  //                 Text(sendMsg),
  //               ],
  //             ),
  //             ),
  //           ),
  //           Column(
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           children: <Widget>[
  //             Container(
  //               margin: const EdgeInsets.only(left: 8.0),
  //               child:  CircleAvatar(
  //                 backgroundImage:
  //                 NetworkImage(currUserImgUrl),//messageSnapshot.value['senderPhotoUrl']),
  //             )),
  //           ],
  //        ),
  //     ];
  // }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      //mainAxisAlignment: MainAxisAlignment.end,children: <Widget>[
      title: Container(
        margin: EdgeInsets.only(left: 40.0),
        //width: MediaQuery.of(context).size.width*0.79,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 8.0, top: 8.0, bottom: 8.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                currUserName,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              Text(
                sendMsg,
                textAlign: TextAlign.start,
              )
            ],
          ),
        ),
      ),
      trailing:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: currUserImgUrl != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(
                      currUserImgUrl), //messageSnapshot.value['senderPhotoUrl']),
                )
              : CircleAvatar(
                  backgroundImage: AssetImage('assets/images/dart_bird.png'),
                ),
        ),
      ]),
    );
  }
}
