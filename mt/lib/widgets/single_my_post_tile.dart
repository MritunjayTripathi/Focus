import 'package:flutter/material.dart';
//import './SingleMyPostTile_overview_screen.dart';
//import '../screen/post_screen.dart';
import 'package:provider/provider.dart';
import '../screen/edit_my_post.dart';
import '../provider/posts.dart';

class SingleMyPostTile extends StatelessWidget {
  final String id;
  final String username;
  final String topic;
  final String description;
  // final String _imageUrl;
  final String tag;

  SingleMyPostTile({
      this.id,
      this.username,
      this.topic,
      this.description,
      // this._imageUrl,
      this.tag});

  //navigating to post screen
  void selectPost(BuildContext ctx) {
    // Navigator.of(ctx).push(
    //   MaterialPageRoute(
    //     builder: (_){
    //       return SingleMyPostTilecreen(_username,_topic);
    //     }),
    // );
   // Navigator.of(ctx).pushNamed(
     // SingleMyPostTilecreen.routeName,
      // arguments: {
      //   'topic': _topic,
      //   'description': _description,
      // },
    //);
  }

  void del(BuildContext ctx){
    final alertDialog=AlertDialog(
      elevation: 4,
      title: Text('Are you sure!'),
     // backgroundColor: Colors.deepPurple[100],
      actions: <Widget>[
         FlatButton(
          child: Text('yes'),
          onPressed: (){
               Provider.of<Posts>(ctx, listen: false).deletePost(id);
            Navigator.of(ctx).pop();
          }
        ),
          FlatButton(
            child: Text('cancel',),
           // Alignment.bottomLeft,
            onPressed: (){
             // Provider.of<MySingleMyPostTile>(ctx, listen: false).deletePost(_id);
              Navigator.of(ctx).pop();
            }
        ),
        ]
    );
    showDialog(

      context: ctx,
      builder: (BuildContext ctx){
        return alertDialog;
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final String str= topic .substring(0,1).toUpperCase();
    return child: InkWell(
              splashColor: Colors.lightBlue[100],
      child: ListTile(
      contentPadding: EdgeInsets.all(10),
      title: Text(topic),
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        radius: 30,
        child: Text(str),
      ),
      // trailing: IconButton(
      //   icon: Icon(Icons.delete),
      //   color: Colors.blue.shade800,
      //   splashColor: Colors.blue,
      //   onPressed: () {
      //     del(context);
      //    // Provider.of<MySingleMyPostTile>(context, listen: false).deletePost(_id);
      //   },
      // ),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        color: Colors.blue.shade800,
        splashColor: Colors.blue,
        onPressed: () {
          // EditMyPost.staticContent=description;
          // EditMyPost.staticDropValue=description;
          // EditMyPost.staticDropValue=tag;
          // EditMyPost.staticUid = id;
          // EditMyPost.staticUser = username;
          Navigator.of(context).pushNamed(EditMyPost.route,arguments: {
            'id':id,
            'topic':topic,
            'description':description,
            'tag': tag,
            'user': username,
          });
          //del(context);
         // Provider.of<MySingleMyPostTile>(context, listen: false).deletePost(_id);
        },
      ),
      onTap: () => selectPost(context),
   //   onLongPress: () =>(){} //sharePost(_description),
      ),    
      );
        }
      
        // sharePost(String description) {
        //   RaisedButton(){
        //     AdvancedShare.generic(title: _topic,msg: _description,);
        //     // .then((response){
        //     //   print(response);
        //     // });
        //   }
        // }
}




// import 'package:flutter/material.dart';
// //import './SingleMyPostTile_overview_screen.dart';
// //import '../screen/post_screen.dart';
// import 'package:provider/provider.dart';
// import '../screen/edit_my_post.dart';
// import '../provider/posts.dart';

// class SingleMyPostTile extends StatelessWidget {
//   final String id;
//   final String username;
//   final String topic;
//   final String description;
//   // final String _imageUrl;
//   final String tag;

//   SingleMyPostTile({
//       this.id,
//       this.username,
//       this.topic,
//       this.description,
//       // this._imageUrl,
//       this.tag});

//   //navigating to post screen
//   void selectPost(BuildContext ctx) {
//     // Navigator.of(ctx).push(
//     //   MaterialPageRoute(
//     //     builder: (_){
//     //       return SingleMyPostTilecreen(_username,_topic);
//     //     }),
//     // );
//    // Navigator.of(ctx).pushNamed(
//      // SingleMyPostTilecreen.routeName,
//       // arguments: {
//       //   'topic': _topic,
//       //   'description': _description,
//       // },
//     //);
//   }

//   void del(BuildContext ctx){
//     final alertDialog=AlertDialog(
//       elevation: 4,
//       title: Text('Are you sure!'),
//      // backgroundColor: Colors.deepPurple[100],
//       actions: <Widget>[
//          FlatButton(
//           child: Text('yes'),
//           onPressed: (){
//                Provider.of<Posts>(ctx, listen: false).deletePost(id);
//             Navigator.of(ctx).pop();
//           }
//         ),
//           FlatButton(
//             child: Text('cancel',),
//            // Alignment.bottomLeft,
//             onPressed: (){
//              // Provider.of<MySingleMyPostTile>(ctx, listen: false).deletePost(_id);
//               Navigator.of(ctx).pop();
//             }
//         ),
//         ]
//     );
//     showDialog(

//       context: ctx,
//       builder: (BuildContext ctx){
//         return alertDialog;
//       }
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final String str= topic .substring(0,1).toUpperCase();
//     return ListTile(
//       contentPadding: EdgeInsets.all(10),
//       title: Text(topic),
//       leading: CircleAvatar(
//         backgroundColor: Colors.blue.shade600,
//         foregroundColor: Colors.white,
//         radius: 30,
//         child: Text(str),
//       ),
//       // trailing: IconButton(
//       //   icon: Icon(Icons.delete),
//       //   color: Colors.blue.shade800,
//       //   splashColor: Colors.blue,
//       //   onPressed: () {
//       //     del(context);
//       //    // Provider.of<MySingleMyPostTile>(context, listen: false).deletePost(_id);
//       //   },
//       // ),
//       trailing: IconButton(
//         icon: Icon(Icons.edit),
//         color: Colors.blue.shade800,
//         splashColor: Colors.blue,
//         onPressed: () {
//           EditMyPost.staticContent=description;
//           EditMyPost.staticDropValue=description;
//           EditMyPost.staticDropValue=tag;
//           Navigator.of(context).pushNamed(EditMyPost.route,arguments: {
//             'id':id,
//             'topic':topic,
//             'description':description,
//             'tag': tag,
//           });
//           //del(context);
//          // Provider.of<MySingleMyPostTile>(context, listen: false).deletePost(_id);
//         },
//       ),
//       onTap: () => selectPost(context),
//    //   onLongPress: () =>(){} //sharePost(_description),
//           );
//         }
      
//         // sharePost(String description) {
//         //   RaisedButton(){
//         //     AdvancedShare.generic(title: _topic,msg: _description,);
//         //     // .then((response){
//         //     //   print(response);
//         //     // });
//         //   }
//         // }
// }
