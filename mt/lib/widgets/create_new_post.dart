import 'dart:math';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/posts.dart';
import '../models/post.dart';
// import '../provpostIders/post_provpostIder.dart';
// import '../screen/posts_overview_screen.dart';

class CreateNewPost extends StatefulWidget {
  static const route = '/new-post';
  @override
  _CreateNewPostState createState() => _CreateNewPostState();
}

class _CreateNewPostState extends State<CreateNewPost> {
  final _tagfocusNode = FocusNode();
  final _contentfocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlfocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  String _btn1SelectedVal = 'Data Structure';

  var _editNewPost = PostInfo(
    postId: null,
    byUser: '',
    tags: '',
    content: '',
    //imageUrl: null,
    userImage: '',
    noOfDownVotes: 0,
    noOfUpvotes: 0,
    title: "",
  );

  var _isLoading = false;

  @override
  void initState() {
    _imageUrlfocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlfocusNode.removeListener(_updateImageUrl);
    _tagfocusNode.dispose();
    _contentfocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlfocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlfocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() async {
    final isValpostId = _form.currentState.validate();
    if (!isValpostId) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

   
      try{
        await  Provider.of<Posts>(context, listen: false)
          .addPost(_editNewPost);
      }catch (error){
         showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text('An error occured!'),
                content:Text('Something went wrong'),
                actions: <Widget>[
                  FlatButton(child: Text('Okay'), onPressed: () {
                    Navigator.of(ctx).pop();
                  },) 
                ],
              ),
          );
          
      }
      //.catchError((error){
      //.then((_) {
      finally{
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    
    // print(_editNewPost.byUser);
    // print(_editNewPost.content);
    // print(_editNewPost.tag);
    // print(_editNewPost.imageUrl);
  }


static const menuItems = <String>[
    'Data Structure',
    'Flutter',
    'Java',
    'Dart',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('write your Post'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Card( 
        color: Colors.lightBlue[50],
        elevation: 3,
        child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(34.0),
              child: Form(
                key: _form,
                
                child: ListView(
                // padding:  EdgeInsets.only(right: 20),
                  children: <Widget>[
                    //Padding(padding:  EdgeInsets.only(right: 30)),
                   
                       TextFormField(
                        decoration: InputDecoration(labelText: 'title',suffixIcon: Icon(Icons.create,size: 21,)),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_tagfocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a tags.';
                          }
                          return null;
                        },
                        onSaved: (value) => {
                          _editNewPost = PostInfo(
                            postId: _editNewPost.postId,
                            byUser: _editNewPost.byUser,
                            title: value,
                            content: _editNewPost.content,
                            noOfDownVotes: _editNewPost.noOfDownVotes,
                            noOfUpvotes: _editNewPost.noOfUpvotes,
                            tags: _editNewPost.tags,
                            userImage: _editNewPost.userImage,
                          ),
                        },
                      ),
                    
                     //  DivpostIder(),
                     Divider(height: 20,color: Color.fromRGBO(0, 0, 0, 0),),
               
                    TextFormField(
                      decoration: InputDecoration(labelText: 'content',suffixIcon: Icon(Icons.create,size: 21,)),
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      focusNode: _contentfocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a content.';
                        }
                        return null;
                      },
                      onSaved: (value) => {
                        _editNewPost = PostInfo(
                          postId: _editNewPost.postId,
                          byUser: _editNewPost.byUser,
                          title: _editNewPost.title,
                          tags: _editNewPost.tags,
                          content: value,
                          noOfDownVotes: _editNewPost.noOfDownVotes,
                          noOfUpvotes: _editNewPost.noOfUpvotes,
                         // tags: _editNewPost.tags,
                          userImage: _editNewPost.userImage
                        ),
                      },
                    ),
                    Divider(color: Color.fromRGBO(0, 0, 0, 0),),
                     ListTile(

                    leading: Text('Select The Catagory  :'),
                     trailing: DropdownButton<String>(
                       // Must be one of items.value.
                       value: _btn1SelectedVal,
                       onChanged: (String newValue) {
                         setState(() {
                          _btn1SelectedVal = newValue;

                          _editNewPost = PostInfo(
                          postId: _editNewPost.postId,
                          byUser: _editNewPost.byUser,
                          content: _editNewPost.content,
                         title: _editNewPost.title,
                          noOfDownVotes: _editNewPost.noOfDownVotes,
                          noOfUpvotes: _editNewPost.noOfUpvotes,
                          userImage: _editNewPost.userImage,
                          tags: _btn1SelectedVal,
                        );

                         }
                         
                         );
                       },
                      
                      // hint: Text('data'),
                       isExpanded: false,
                       items: this._dropDownMenuItems,
                     ),
                     
                    //  onTap: () =>{
                    //     _editNewPost = PostInfo(
                    //       postId: _editNewPost.postId,
                    //       byUser: _editNewPost.byUser,
                    //       tags: _editNewPost.tags,
                    //       content: _editNewPost.content,
                    //       imageUrl: _editNewPost.imageUrl,
                    //       tag: _btn1SelectedVal,
                    //     ),
                    //    }, 
                   ),
                  
                  Divider(color: Color.fromRGBO(0, 0, 0, 0),),
                  //  DivpostIder(height: 30,color: Color.fromRGBO(0, 0, 0, 0),),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.end,
                    //   children: <Widget>[
                        
                    //     Container(
                    //         width: 100,
                    //         height: 100,
                    //         margin: EdgeInsets.only(top: 12, right: 10),
                    //         decoration: BoxDecoration(
                    //           border: Border.all(
                    //             width: 3,
                    //             color: Colors.black38,
                    //           ),
                    //         ),
                    //         child: _imageUrlController.text.isEmpty
                    //             ? Text('Enter Image Url')
                    //             : FittedBox(
                    //                 child: Image.network(
                    //                   _imageUrlController.text,
                    //                   fit: BoxFit.cover,
                    //                 ),
                    //               )),
                    //     Expanded(
                    //       child: TextFormField(
                    //         decoration: InputDecoration(labelText: 'Image URL',suffixIcon: Icon(Icons.create,size: 20,)),
                    //         keyboardType: TextInputType.url,
                    //         textInputAction: TextInputAction.done,
                    //         controller: _imageUrlController,
                    //         focusNode: _imageUrlfocusNode,
                    //         onFieldSubmitted: (_) {
                    //           _saveForm();
                    //         },
                    //         onSaved: (value) => {
                    //           _editNewPost = PostInfo(
                    //             postId: _editNewPost.postId,
                    //             byUser: _editNewPost.byUser,
                    //             tags: _editNewPost.tags,
                    //             content: _editNewPost.content,
                    //             userImage: value,
                    //             noOfDownVotes: _editNewPost.noOfDownVotes,
                    //             noOfUpvotes: _editNewPost.noOfUpvotes,
                    //             title: _editNewPost.title,
                    //             //tags: _editNewPost.tags,
                    //           ),
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                     Divider(height: 40,color: Color.fromRGBO(0, 0, 0, 0),),

                     RaisedButton(
                          child: Text('Submit'),
                          color: Colors.blue[200],
                          elevation: 4,
                          hoverColor: Colors.brown,
                          onPressed:  (){
                              _saveForm();
                          },),
                  ],
                ),
              ),
            ),
    ),
    );
  }
}
