import 'package:flutter/material.dart';

class EditMyPost extends StatelessWidget {
  static final String route = '/edit-my-post';


  TextEditingController titleController=TextEditingController();
  TextEditingController contentController=TextEditingController();
  @override
  Widget build(BuildContext context) {




    return Column(
        children: <Widget>[
          TextField(
            controller: titleController,
            maxLines: 3,
          ),
           TextField(
            controller: titleController,
            maxLines: 3,
          ),
          RaisedButton(
            child: Text('Submit'),
            onPressed: (){},
          )
        ],
    );
  }
}




















// import 'dart:math';

// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

// import '../provider/posts.dart';
// import '../models/post.dart';
// // import '../provpostIders/post_provpostIder.dart';
// // import '../screen/posts_overview_screen.dart';

// class EditMyPost extends StatefulWidget {
//   static final String route = '/edit-my-post';
//   static String staticUid = null;
//   static String staticTitle = null;
//   static String staticContent = null;
//   static String staticDropValue = null;
//   static String staticUser = null;

//   @override
//   _EditMyPostState createState() => _EditMyPostState();
// }



// class _EditMyPostState extends State<EditMyPost> {
//   final _tagfocusNode = FocusNode();
//   final _contentfocusNode = FocusNode();
//   final _imageUrlController = TextEditingController();
//   final _imageUrlfocusNode = FocusNode();
//   final _form = GlobalKey<FormState>();
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
  
//   String _btn1SelectedVal;
  
//   var _isLoading = false;
//   Map<String,String> postDetail;
//   PostInfo _editNewPost;


//   @override
//   void initState() {
//     super.initState();
//   }
   


//   @override
//   void dispose() {
//     _imageUrlfocusNode.removeListener(_updateImageUrl);
//     _tagfocusNode.dispose();
//     _contentfocusNode.dispose();
//     _imageUrlController.dispose();
//     _imageUrlfocusNode.dispose();
//     super.dispose();
//   }

//   void _updateImageUrl() {
//     if (!_imageUrlfocusNode.hasFocus) {
//       setState(() {});
//     }
//   }

//   void _saveForm() async {
//     final isValpostId = _form.currentState.validate();
//     if (!isValpostId) {
//       return;
//     }
//     _form.currentState.save();
//     setState(() {
//       _isLoading = true;
//     });

     
    
//       try{
//         //****update post */
//           print("Saving form in Update List");
//          await  Provider.of<Posts>(context, listen: false)
//           .updatePost({
//             'title':titleController.text,
//             'content':descriptionController.text,
//             'tag':_btn1SelectedVal,
//           });


//         // await  Provider.of<Posts>(context, listen: false)
//         //   .addPost(_editNewPost);
//       }catch (error){
//          showDialog(
//               context: context,
//               builder: (ctx) => AlertDialog(
//                 title: Text('An error occured!'),
//                 content:Text('Something went wrong'),
//                 actions: <Widget>[
//                   FlatButton(child: Text('Okay'), onPressed: () {
//                     Navigator.of(ctx).pop();
//                   },) 
//                 ],
//               ),
//           );
          
//       }
//       //.catchError((error){
//       //.then((_) {
//       finally{
//         setState(() {
//           _isLoading = false;
//         });
//         Navigator.of(context).pop();
//       }
//   }


// static const menuItems = <String>[
//     'Data Structure',
//     'Flutter',
//     'Java',
//     'Dart',
//   ];
//   final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
//       .map(
//         (String value) => DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         ),
//       )
//       .toList();
//   @override
//   Widget build(BuildContext context) {



    
//    postDetail = ModalRoute.of(context).settings.arguments as Map<String, String>;
//     _imageUrlfocusNode.addListener(_updateImageUrl);
//     _editNewPost= PostInfo(
//     postId: EditMyPost.staticUid,//postDetail['id'],
//     byUser: EditMyPost.staticUser,//postDetail['user'],
//     tags: EditMyPost.staticDropValue,//postDetail['tag'],
//     content: EditMyPost.staticUid,//postDetail['description'],
//     //imageUrl: null,
//     userImage: '',
//     noOfDownVotes: 0,
//     noOfUpvotes: 0,
//     title: EditMyPost.staticTitle,//postDetail['topic'],
//   );
//     // _btn1SelectedVal = postDetail['tag'];
//     // titleController.text = postDetail['topic'];
//     // descriptionController.text = postDetail['description'];

//     _btn1SelectedVal = EditMyPost.staticDropValue;
//     titleController.text = EditMyPost.staticTitle;
//     descriptionController.text = EditMyPost.staticContent;

    
    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('write your Post'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: _saveForm,
//           ),
//         ],
//       ),
//       body: Card( 
//         color: Colors.lightBlue[50],
//         elevation: 3,
//         child: _isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Padding(
//               padding: const EdgeInsets.all(34.0),
//               child: Form(
//                 key: _form,
                
//                 child: ListView(
//                 // padding:  EdgeInsets.only(right: 20),
//                   children: <Widget>[

//                     //Padding(padding:  EdgeInsets.only(right: 30)),
                   
//                        TextField(
                      
                         
//                          controller: titleController, 
//                         //    onEditingComplete: (){
//                         //    EditMyPost.staticTitle=titleController.text;
//                         //  },
//                         onChanged:  (text) {
//                           EditMyPost.staticTitle = text;
//                         },
//                         decoration: InputDecoration(labelText: 'title',suffixIcon: Icon(Icons.create,size: 21,)),
//                         textInputAction: TextInputAction.next,
//                         // onFieldSubmitted: (_) {
//                         //   FocusScope.of(context).requestFocus(_tagfocusNode);
//                         // },
//                         // validator: (value) {
//                         //   if (value.isEmpty) {
//                         //     return 'Please provide a tags.';
//                         //   }
//                         //   return null;
//                         // },
//                         // onSaved: (value)  {
                          
//                         //    EditMyPost.staticTitle=titleController.text;
                          
//                         //   // _editNewPost = PostInfo(
//                         //   //   postId: _editNewPost.postId,
//                         //   //   byUser: _editNewPost.byUser,
//                         //   //   title: value,
//                         //   //   content: _editNewPost.content,
//                         //   //   noOfDownVotes: _editNewPost.noOfDownVotes,
//                         //   //   noOfUpvotes: _editNewPost.noOfUpvotes,
//                         //   //   tags: _editNewPost.tags,
//                         //   //   userImage: _editNewPost.userImage,
//                         //   // ),
//                         // },
//                       ),
                    
//                      //  DivpostIder(),
//                      Divider(height: 20,color: Color.fromRGBO(0, 0, 0, 0),),
               
//                     TextField(
                       
//                       controller: descriptionController,
//                       //  onEditingComplete: (){
//                       //      EditMyPost.staticContent=descriptionController.text;
//                       //    },
//                       onChanged:  (text) {
//                         EditMyPost.staticContent = text;
//                       },
//                       decoration: InputDecoration(labelText: 'content',suffixIcon: Icon(Icons.create,size: 21,)),
//                       maxLines: 4,
//                       keyboardType: TextInputType.multiline,
//                       focusNode: _contentfocusNode,
//                       // validator: (value) {
//                       //   if (value.isEmpty) {
//                       //     return 'Please provide a content.';
//                       //   }
//                       //   return null;
//                       // },
//                       // onSaved: (value)  {
                        
//                       //      EditMyPost.staticContent=descriptionController.text;
//                       //   _editNewPost = PostInfo(
//                       //     postId: _editNewPost.postId,
//                       //     byUser: _editNewPost.byUser,
//                       //     title: _editNewPost.title,
//                       //     tags: _editNewPost.tags,
//                       //     content: value,
//                       //     noOfDownVotes: _editNewPost.noOfDownVotes,
//                       //     noOfUpvotes: _editNewPost.noOfUpvotes,
//                       //    // tags: _editNewPost.tags,
//                       //     userImage: _editNewPost.userImage
//                       //   );
//                       // },
//                     ),
//                     Divider(color: Color.fromRGBO(0, 0, 0, 0),),
//                      ListTile(

//                     leading: Text('Select The Catagory  :'),
//                      trailing: DropdownButton<String>(
//                        // Must be one of items.value.
//                        value: _btn1SelectedVal,
//                        onChanged: (String newValue) {
//                          setState(() {
//                           _btn1SelectedVal = newValue;

//                           _editNewPost = PostInfo(
//                           postId: _editNewPost.postId,
//                           byUser: _editNewPost.byUser,
//                           content: _editNewPost.content,
//                          title: _editNewPost.title,
//                           noOfDownVotes: _editNewPost.noOfDownVotes,
//                           noOfUpvotes: _editNewPost.noOfUpvotes,
//                           userImage: _editNewPost.userImage,
//                           tags: _btn1SelectedVal,
//                         );

//                          }
                         
//                          );
//                        },
                      
//                       // hint: Text('data'),
//                        isExpanded: false,
//                        items: this._dropDownMenuItems,
//                      ),
                     
//                     //  onTap: () =>{
//                     //     _editNewPost = PostInfo(
//                     //       postId: _editNewPost.postId,
//                     //       byUser: _editNewPost.byUser,
//                     //       tags: _editNewPost.tags,
//                     //       content: _editNewPost.content,
//                     //       imageUrl: _editNewPost.imageUrl,
//                     //       tag: _btn1SelectedVal,
//                     //     ),
//                     //    }, 
//                    ),
                  
//                   Divider(color: Color.fromRGBO(0, 0, 0, 0),),
//                   //  DivpostIder(height: 30,color: Color.fromRGBO(0, 0, 0, 0),),
//                     // Row(
//                     //   crossAxisAlignment: CrossAxisAlignment.end,
//                     //   children: <Widget>[
                        
//                     //     Container(
//                     //         width: 100,
//                     //         height: 100,
//                     //         margin: EdgeInsets.only(top: 12, right: 10),
//                     //         decoration: BoxDecoration(
//                     //           border: Border.all(
//                     //             width: 3,
//                     //             color: Colors.black38,
//                     //           ),
//                     //         ),
//                     //         child: _imageUrlController.text.isEmpty
//                     //             ? Text('Enter Image Url')
//                     //             : FittedBox(
//                     //                 child: Image.network(
//                     //                   _imageUrlController.text,
//                     //                   fit: BoxFit.cover,
//                     //                 ),
//                     //               )),
//                     //     Expanded(
//                     //       child: TextFormField(
//                     //         decoration: InputDecoration(labelText: 'Image URL',suffixIcon: Icon(Icons.create,size: 20,)),
//                     //         keyboardType: TextInputType.url,
//                     //         textInputAction: TextInputAction.done,
//                     //         controller: _imageUrlController,
//                     //         focusNode: _imageUrlfocusNode,
//                     //         onFieldSubmitted: (_) {
//                     //           _saveForm();
//                     //         },
//                     //         onSaved: (value) => {
//                     //           _editNewPost = PostInfo(
//                     //             postId: _editNewPost.postId,
//                     //             byUser: _editNewPost.byUser,
//                     //             tags: _editNewPost.tags,
//                     //             content: _editNewPost.content,
//                     //             userImage: value,
//                     //             noOfDownVotes: _editNewPost.noOfDownVotes,
//                     //             noOfUpvotes: _editNewPost.noOfUpvotes,
//                     //             title: _editNewPost.title,
//                     //             //tags: _editNewPost.tags,
//                     //           ),
//                     //         },
//                     //       ),
//                     //     ),
//                     //   ],
//                     // ),
//                      Divider(height: 40,color: Color.fromRGBO(0, 0, 0, 0),),

//                      RaisedButton(
//                           child: Text('Submit'),
//                           color: Colors.blue[200],
//                           elevation: 4,
//                           hoverColor: Colors.brown,
//                           onPressed:  (){
//                               _saveForm();
//                           },),
//                   ],
//                 ),
//               ),
//             ),
//     ),
//     );
//   }
// }



// import 'dart:math';

// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

// import '../provider/posts.dart';
// import '../models/post.dart';
// // import '../provpostIders/post_provpostIder.dart';
// // import '../screen/posts_overview_screen.dart';

// class EditMyPost extends StatefulWidget {
//   static final String route = '/edit-my-post';
//   static String staticTitle;
//   static String staticContent;
//   static String staticDropValue;

//   @override
//   _EditMyPostState createState() => _EditMyPostState();
// }



// class _EditMyPostState extends State<EditMyPost> {
//   final _tagfocusNode = FocusNode();
//   final _contentfocusNode = FocusNode();
//   final _imageUrlController = TextEditingController();
//   final _imageUrlfocusNode = FocusNode();
//   final _form = GlobalKey<FormState>();
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   // titleController.text = EditMyPost.staticTitle;
  
//   String _btn1SelectedVal;
  
//   var _isLoading = false;
//   Map<String,String> postDetail;
//   PostInfo _editNewPost;


//   @override
//   void initState() {
//     super.initState();
//   }
   


//   @override
//   void dispose() {
//     _imageUrlfocusNode.removeListener(_updateImageUrl);
//     _tagfocusNode.dispose();
//     _contentfocusNode.dispose();
//     _imageUrlController.dispose();
//     _imageUrlfocusNode.dispose();
//     super.dispose();
//   }

//   void _updateImageUrl() {
//     if (!_imageUrlfocusNode.hasFocus) {
//       setState(() {});
//     }
//   }

//   void _saveForm() async {
//     final isValpostId = _form.currentState.validate();
//     if (!isValpostId) {
//       return;
//     }
//     _form.currentState.save();
//     setState(() {
//       _isLoading = true;
//     });

     
    
//       try{
//         //****update post */
//           print("Saving form in Update List");
//          await  Provider.of<Posts>(context, listen: false)
//           .updatePost({
//             'title':titleController.text,
//             'content':descriptionController.text,
//             'tag':_btn1SelectedVal,
//           });


//         // await  Provider.of<Posts>(context, listen: false)
//         //   .addPost(_editNewPost);
//       }catch (error){
//          showDialog(
//               context: context,
//               builder: (ctx) => AlertDialog(
//                 title: Text('An error occured!'),
//                 content:Text('Something went wrong'),
//                 actions: <Widget>[
//                   FlatButton(child: Text('Okay'), onPressed: () {
//                     Navigator.of(ctx).pop();
//                   },) 
//                 ],
//               ),
//           );
          
//       }
//       //.catchError((error){
//       //.then((_) {
//       finally{
//         setState(() {
//           _isLoading = false;
//         });
//         Navigator.of(context).pop();
//       }
//   }


// static const menuItems = <String>[
//     'Data Structure',
//     'Flutter',
//     'Java',
//     'Dart',
//   ];
//   final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
//       .map(
//         (String value) => DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         ),
//       )
//       .toList();
//   @override
//   Widget build(BuildContext context) {



    
//    postDetail = ModalRoute.of(context).settings.arguments as Map<String, String>;
//     _imageUrlfocusNode.addListener(_updateImageUrl);
//     _editNewPost= PostInfo(
//     postId: postDetail['id'],
//     byUser: '',
//     tags: postDetail['tag'],
//     content: postDetail['description'],
//     //imageUrl: null,
//     userImage: '',
//     noOfDownVotes: 0,
//     noOfUpvotes: 0,
//     title: postDetail['topic'],
//   );
//     _btn1SelectedVal = postDetail['tag'];
//     titleController.text = postDetail['topic'];
//     descriptionController.text = postDetail['description'];

//     _btn1SelectedVal = EditMyPost.staticDropValue;
//     titleController.text = EditMyPost.staticTitle;
//     descriptionController.text = EditMyPost.staticContent;

    
    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('write your Post'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: _saveForm,
//           ),
//         ],
//       ),
//       body: Card( 
//         color: Colors.lightBlue[50],
//         elevation: 3,
//         child: _isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Padding(
//               padding: const EdgeInsets.all(34.0),
//               child: Form(
//                 key: _form,
                
//                 child: ListView(
//                 // padding:  EdgeInsets.only(right: 20),
//                   children: <Widget>[

//                     //Padding(padding:  EdgeInsets.only(right: 30)),
                   
//                        TextField(
                      
                         
//                          controller: titleController, 
//                         //    onEditingComplete: (text){
//                         //    EditMyPost.staticTitle=text;
//                         //  },
                         
//                         decoration: InputDecoration(labelText: 'title',suffixIcon: Icon(Icons.create,size: 21,)),
//                         textInputAction: TextInputAction.next,
//                         // onFieldSubmitted: (_) {
//                         //   FocusScope.of(context).requestFocus(_tagfocusNode);
//                         // },
//                         // validator: (value) {
//                         //   if (value.isEmpty) {
//                         //     return 'Please provide a tags.';
//                         //   }
//                         //   return null;
//                         // },
//                         // onSaved: (value)  {
                          
//                         //    EditMyPost.staticTitle=titleController.text;
                          
//                         //   // _editNewPost = PostInfo(
//                         //   //   postId: _editNewPost.postId,
//                         //   //   byUser: _editNewPost.byUser,
//                         //   //   title: value,
//                         //   //   content: _editNewPost.content,
//                         //   //   noOfDownVotes: _editNewPost.noOfDownVotes,
//                         //   //   noOfUpvotes: _editNewPost.noOfUpvotes,
//                         //   //   tags: _editNewPost.tags,
//                         //   //   userImage: _editNewPost.userImage,
//                         //   // ),
//                         // },
//                       ),
                    
//                      //  DivpostIder(),
//                      Divider(height: 20,color: Color.fromRGBO(0, 0, 0, 0),),
               
//                     TextFormField(
                       
//                       controller: descriptionController,
//                        onEditingComplete: (){
//                            EditMyPost.staticContent=descriptionController.text;
//                          },
//                       decoration: InputDecoration(labelText: 'content',suffixIcon: Icon(Icons.create,size: 21,)),
//                       maxLines: 4,
//                       keyboardType: TextInputType.multiline,
//                       focusNode: _contentfocusNode,
//                       validator: (value) {
//                         if (value.isEmpty) {
//                           return 'Please provide a content.';
//                         }
//                         return null;
//                       },
//                       onSaved: (value)  {
                        
//                         _editNewPost = PostInfo(
//                           postId: _editNewPost.postId,
//                           byUser: _editNewPost.byUser,
//                           title: _editNewPost.title,
//                           tags: _editNewPost.tags,
//                           content: value,
//                           noOfDownVotes: _editNewPost.noOfDownVotes,
//                           noOfUpvotes: _editNewPost.noOfUpvotes,
//                          // tags: _editNewPost.tags,
//                           userImage: _editNewPost.userImage
//                         );
//                       },
//                     ),
//                     Divider(color: Color.fromRGBO(0, 0, 0, 0),),
//                      ListTile(

//                     leading: Text('Select The Catagory  :'),
//                      trailing: DropdownButton<String>(
//                        // Must be one of items.value.
//                        value: _btn1SelectedVal,
//                        onChanged: (String newValue) {
//                          setState(() {
//                           _btn1SelectedVal = newValue;

//                           _editNewPost = PostInfo(
//                           postId: _editNewPost.postId,
//                           byUser: _editNewPost.byUser,
//                           content: _editNewPost.content,
//                          title: _editNewPost.title,
//                           noOfDownVotes: _editNewPost.noOfDownVotes,
//                           noOfUpvotes: _editNewPost.noOfUpvotes,
//                           userImage: _editNewPost.userImage,
//                           tags: _btn1SelectedVal,
//                         );

//                          }
                         
//                          );
//                        },
                      
//                       // hint: Text('data'),
//                        isExpanded: false,
//                        items: this._dropDownMenuItems,
//                      ),
                     
//                     //  onTap: () =>{
//                     //     _editNewPost = PostInfo(
//                     //       postId: _editNewPost.postId,
//                     //       byUser: _editNewPost.byUser,
//                     //       tags: _editNewPost.tags,
//                     //       content: _editNewPost.content,
//                     //       imageUrl: _editNewPost.imageUrl,
//                     //       tag: _btn1SelectedVal,
//                     //     ),
//                     //    }, 
//                    ),
                  
//                   Divider(color: Color.fromRGBO(0, 0, 0, 0),),
//                   //  DivpostIder(height: 30,color: Color.fromRGBO(0, 0, 0, 0),),
//                     // Row(
//                     //   crossAxisAlignment: CrossAxisAlignment.end,
//                     //   children: <Widget>[
                        
//                     //     Container(
//                     //         width: 100,
//                     //         height: 100,
//                     //         margin: EdgeInsets.only(top: 12, right: 10),
//                     //         decoration: BoxDecoration(
//                     //           border: Border.all(
//                     //             width: 3,
//                     //             color: Colors.black38,
//                     //           ),
//                     //         ),
//                     //         child: _imageUrlController.text.isEmpty
//                     //             ? Text('Enter Image Url')
//                     //             : FittedBox(
//                     //                 child: Image.network(
//                     //                   _imageUrlController.text,
//                     //                   fit: BoxFit.cover,
//                     //                 ),
//                     //               )),
//                     //     Expanded(
//                     //       child: TextFormField(
//                     //         decoration: InputDecoration(labelText: 'Image URL',suffixIcon: Icon(Icons.create,size: 20,)),
//                     //         keyboardType: TextInputType.url,
//                     //         textInputAction: TextInputAction.done,
//                     //         controller: _imageUrlController,
//                     //         focusNode: _imageUrlfocusNode,
//                     //         onFieldSubmitted: (_) {
//                     //           _saveForm();
//                     //         },
//                     //         onSaved: (value) => {
//                     //           _editNewPost = PostInfo(
//                     //             postId: _editNewPost.postId,
//                     //             byUser: _editNewPost.byUser,
//                     //             tags: _editNewPost.tags,
//                     //             content: _editNewPost.content,
//                     //             userImage: value,
//                     //             noOfDownVotes: _editNewPost.noOfDownVotes,
//                     //             noOfUpvotes: _editNewPost.noOfUpvotes,
//                     //             title: _editNewPost.title,
//                     //             //tags: _editNewPost.tags,
//                     //           ),
//                     //         },
//                     //       ),
//                     //     ),
//                     //   ],
//                     // ),
//                      Divider(height: 40,color: Color.fromRGBO(0, 0, 0, 0),),

//                      RaisedButton(
//                           child: Text('Submit'),
//                           color: Colors.blue[200],
//                           elevation: 4,
//                           hoverColor: Colors.brown,
//                           onPressed:  (){
//                               _saveForm();
//                           },),
//                   ],
//                 ),
//               ),
//             ),
//     ),
//     );
//   }
// }
