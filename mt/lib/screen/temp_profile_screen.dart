import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
//import 'package:pull_to_refresh/pull_to_refresh.dart';

class UploadImage extends StatefulWidget {
  static final String route = '/editImageScreen';
  static String src = 'https://www.hawtcelebs.com/wp-content/uploads/2019/04/josephine-langford-for-cosmopolitan-magazine-april-2019-2_thumbnail.jpg';

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
   static File image;
  // pickerG() async{
  //   //print('Picker is called');
  //   File img = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 50,maxHeight: 800,maxWidth: 600);
  //   image=img;
  //   //print(img.path);
  //   if(img != null){
  //   //print(img.path);
  //   setState(() { });
  //   Navigator.of(context).pop();
  //   }
  // }
  // pickerC() async{
  //   //print('Picker is called');
  //   File img = await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 50,maxHeight: 800,maxWidth: 600);
  //   image=img;
  //   //print(img.path);
  //   if(img != null){
  //   //print(img.path);
  //   setState(() { });
  //   Navigator.of(context).pop();
  //   }
  // }   

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
      body: Center(child: (image == null)? Image.network(UploadImage.src): Image.file(image),),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.black,
      //   onPressed: (){
      //     showDialog<String>(
      //       context: context,
      //       builder: (BuildContext context) => SimpleDialog(
      //             title: Text('Upload: '),
      //             children: <Widget>[
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                 children: <Widget>[
      //                   IconButton(
      //                       tooltip: 'gallery',
      //                       iconSize: 32,
      //                       color: Colors.black,
      //                       onPressed: pickerG,
      //                       icon: Icon(Icons.filter),
      //                   ),
      //                   IconButton(
      //                       tooltip: 'camera',
      //                       iconSize: 32,
      //                       color: Colors.black,
      //                       onPressed: pickerC,
      //                       icon: Icon(Icons.camera_alt),
      //                   ),
      //                 ],
      //               )
      //             ],
      //           ));
      //   },
      //   child: Icon(Icons.camera_alt, ),
      // ),
    );
  }
}
