import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mt/models/firebase_constants.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path/src/path_set.dart';
import '../models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';

class UploadImage extends StatefulWidget {
  static String currUserImageUri=User.imgUrl;
  static final String route = '/editImageScreen';
  static String src =
      'https://www.hawtcelebs.com/wp-content/uploads/2019/04/josephine-langford-for-cosmopolitan-magazine-april-2019-2_thumbnail.jpg';

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  static File image;
  static String uploadedFileURL;
  pickerG(BuildContext context) async {
    //print('Picker is called');
    File img = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 800,
        maxWidth: 600);
    image = img;
    //print(img.path);
    if (img != null) {
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child('user/images/${User.userUid}/');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        setState(() async {
          uploadedFileURL = fileURL; // or userImgUrl = fileURL;
          await kFirebaseDbRef
              .child('users')
              .child(User.userUid)
              .child('info')
              .update({'imageUri': uploadedFileURL});
              
          UploadImage.currUserImageUri=uploadedFileURL;
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });
      });
      //print(img.path);
      setState(() {});
    }
  }

  pickerC(BuildContext context) async {
    //print('Picker is called');
    File img = await ImagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 800,
        maxWidth: 600);
    image = img;
    //print(img.path);
    if (img != null) {
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child('user/images/${User.userUid}/');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        setState(() async {
          uploadedFileURL = fileURL; // or userImgUrl = fileURL;

          await kFirebaseDbRef
              .child('users')
              .child(User.userUid)
              .child('info')
              .update({'imageUri': uploadedFileURL});
              
          UploadImage.currUserImageUri=uploadedFileURL;
          Navigator.of(context).pop();

          Navigator.of(context).pop();
        });
      });
      //print(img.path);
      setState(() {});
    }
  }

  Future uploadFile() async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('user/info/images/');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        //  uploadedFileURL = fileURL;// or userImgUrl = fileURL;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Profile Pic',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      // body: Builder(
      //   builder: (context)=> Center(child: (image == null)? Image.network(UploadImage.src): Image.file(image),),
      // ),
      body: Center(
        child: (image == null)
            ? Image.network(UploadImage.currUserImageUri)
            : Image.file(image),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => SimpleDialog(
                    title: Text('Upload: '),
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            tooltip: 'gallery',
                            iconSize: 32,
                            color: Colors.black,
                            onPressed: () {
                              pickerG(context);
                            },
                            icon: Icon(Icons.add_photo_alternate),
                          ),
                          IconButton(
                            tooltip: 'camera',
                            iconSize: 32,
                            color: Colors.black,
                            onPressed: () {
                              pickerC(context);
                            },
                            icon: Icon(Icons.add_a_photo),
                          ),
                        ],
                      )
                    ],
                  ));
        },
        child: Icon(
          Icons.add_a_photo,
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// //import 'package:pull_to_refresh/pull_to_refresh.dart';

// class UploadImage extends StatefulWidget {
//   static final String route = '/editImageScreen';
//   static String src = 'https://www.hawtcelebs.com/wp-content/uploads/2019/04/josephine-langford-for-cosmopolitan-magazine-april-2019-2_thumbnail.jpg';

//   @override
//   _UploadImageState createState() => _UploadImageState();
// }

// class _UploadImageState extends State<UploadImage> {
//   static File image;
//   pickerG() async{
//     //print('Picker is called');
//     File img = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 50,maxHeight: 800,maxWidth: 600);
//     image=img;
//     //print(img.path);
//     if(img != null){
//     //print(img.path);
//     setState(() { });
//     Navigator.of(context).pop();
//     }
//   }
//   pickerC() async{
//     //print('Picker is called');
//     File img = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 50,maxHeight: 800,maxWidth: 600);
//     image=img;
//     //print(img.path);
//     if(img != null){
//     //print(img.path);
//     setState(() { });
//     Navigator.of(context).pop();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black87,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text(
//           'Profile Pic',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: Center(child: (image == null)? Image.network(UploadImage.src): Image.file(image),),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.black,
//         onPressed: (){
//           showDialog<String>(
//             context: context,
//             builder: (BuildContext context) => SimpleDialog(
//                   title: Text('Upload: '),
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         IconButton(
//                             tooltip: 'gallery',
//                             iconSize: 32,
//                             color: Colors.black,
//                             onPressed: pickerG,
//                             icon: Icon(Icons.filter),
//                         ),
//                         IconButton(
//                             tooltip: 'camera',
//                             iconSize: 32,
//                             color: Colors.black,
//                             onPressed: pickerC,
//                             icon: Icon(Icons.camera_alt),
//                         ),
//                       ],
//                     )
//                   ],
//                 ));
//         },
//         child: Icon(Icons.camera_alt, ),
//       ),
//     );
//   }
// }
