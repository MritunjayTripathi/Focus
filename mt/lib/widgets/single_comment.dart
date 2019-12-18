import 'package:flutter/material.dart';

class SingleComment extends StatelessWidget {

  
  final String userName;
  final String comment;
  final String userImgUrl;
  final heightOfDevice;

  SingleComment(this.userName,this.comment,this.userImgUrl,this.heightOfDevice);


  

  @override
  Widget build(BuildContext context) {
      

      final userImg = CircleAvatar(
      radius: heightOfDevice * 0.04,
      backgroundImage: NetworkImage(
        userImgUrl,
      ),
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
              userImg,
              Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      text: '',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                            text: userName + ': ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                        TextSpan(
                          text: comment,
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
}