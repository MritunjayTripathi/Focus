import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class BottomNavigationPostDetail extends StatefulWidget {
  var noOfUpvote;
  var noOfDownVote;
  final postId;

  BottomNavigationPostDetail({this.noOfDownVote, this.noOfUpvote, this.postId});

  @override
  _BottomNavigationPostDetailState createState() =>
      _BottomNavigationPostDetailState();
}

class _BottomNavigationPostDetailState
    extends State<BottomNavigationPostDetail> {
  int type;
  int bookmarkType;
  UserProvider ob;

  @override
  void initState() {
    ob = Provider.of<UserProvider>(context, listen: false);
    //.voteType(widget.postId);
    print("this is the ob object bottom navigation");
    print(ob);
    print('type');
    type = ob.voteType(widget.postId);
    print(type);
    print('btype');

    bookmarkType = ob.bookmarkType(widget.postId);
    print(bookmarkType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

     
    final upvotesCount = Text(
      widget.noOfUpvote.toString(),
      style: TextStyle(
          color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 12),
    );

    final downvotesCount = Text(
      widget.noOfDownVote.toString(),
      style: TextStyle(
          color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 12),
    );

/*
Implementation of OnPressed Icons goes below
*/
    final upVoteIcon = IconButton(
      tooltip: 'Upvote',
      icon: Icon(Icons.thumb_up),
      iconSize: 30,
      color: type == 2 ?  Colors.blue:Colors.black38 ,
      onPressed: () {
       // setState(() {
          if (type == 2) {
            type = 0;
            widget.noOfUpvote = widget.noOfUpvote - 1;
          } else {
            if(type==1)
            {
              widget.noOfDownVote=widget.noOfDownVote-1;
            }
            type = 2;
            widget.noOfUpvote = widget.noOfUpvote + 1;
          }
          
          ob.upVote(widget.postId, widget.noOfUpvote,widget.noOfDownVote, type);
       // });
       setState(() {
         type=type;
       });
      },
    );

    final downVoteIcon = IconButton(
      tooltip: 'Downvote',
      icon: Icon(Icons.thumb_down),
      iconSize: 30,
      color: type == 1 ?Colors.blue: Colors.black38,
      onPressed: () {
       // setState(() {
          if (type == 1){
            type = 0;
            widget.noOfDownVote=widget.noOfDownVote-1;
            
          }
          else
          {
            if(type==2)
            {
              widget.noOfUpvote=widget.noOfUpvote-1;
            }
            type = 1;
            widget.noOfDownVote=widget.noOfDownVote+1;
          }
          ob.downVote(widget.postId,  widget.noOfUpvote,widget.noOfDownVote, type);
          
       // });
       setState(() {
         type=type;
       });

        
      },
    );

    final bookmarkIcon = IconButton(
      tooltip: 'Bookmark',
      icon: bookmarkType == 0
          ? Icon(Icons.bookmark_border)
          : Icon(Icons.bookmark),
      iconSize: 30,
      color: Colors.blue,
      onPressed: () {
        setState(() {
          bookmarkType = bookmarkType == 0 ? 1 : 0;
          ob.bookmarkMe(widget.postId, bookmarkType);
        });
      },
    );

    final shareIcon = IconButton(
      tooltip: 'Share',
      icon: Icon(Icons.share),
      iconSize: 30,
      color: Colors.blue,
      onPressed: () {},
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[upvotesCount, upVoteIcon],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[downvotesCount, downVoteIcon],
        ),
        bookmarkIcon,
        shareIcon
      ],
    );
  }
}
