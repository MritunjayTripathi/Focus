import 'package:flutter/material.dart';

class RecievedMsgUI extends StatelessWidget {
  final String otherUserName;
  final String otherUserImgUrl;
  final String recievedMsg;


  RecievedMsgUI({
    this.otherUserName,
    this.otherUserImgUrl,
    this.recievedMsg,
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
  //                 Text(otherUserName, style: Theme.of(context).textTheme.subhead),
  //                 Text(
  //                   'time',
  //                   //DateTime.fromMillisecondsSinceEpoch(sentTime).toString(),
  //                   style: Theme.of(context).textTheme.caption,
  //                 ),
  //                 Text(recievedMsg),
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
  //                 NetworkImage(otherUserImgUrl),//messageSnapshot.value['recievederPhotoUrl']),
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
        margin: EdgeInsets.only(right: 40.0),
        //width: MediaQuery.of(context).size.width*0.79,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 8.0, top: 8.0, bottom: 8.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                otherUserName,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              Text(
                recievedMsg,
                textAlign: TextAlign.start,
              )
            ],
          ),
        ),
      ),
      leading:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: otherUserImgUrl != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(
                      otherUserImgUrl), //messageSnapshot.value['senderPhotoUrl']),
                )
              : CircleAvatar(
                  backgroundImage: AssetImage('assets/images/dart_bird.png'),
                ),
        ),
      ]),
    );
  }
}
