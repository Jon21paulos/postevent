import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'post.dart';



class form extends StatefulWidget {
  const form({Key? key}) : super(key: key);

  @override
  _formState createState() => _formState();
}

class _formState extends State<form> {
  String url="";
  File? file;
  final texttitleController = TextEditingController();
  final textsubtitleController = TextEditingController();

  ImagePicker image = ImagePicker();
  CollectionReference post =
  FirebaseFirestore.instance.collection('post');


  uploadFile() async{
    var imageFile = FirebaseStorage.instance.ref().child("/path").child("/.jpg");
    UploadTask task = imageFile.putFile(file!);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
    // await FirebaseFirestore.instance
    //     .collection("post")
    //     .doc()
    //     .set({"title","subtitile","imageUrl":url});
    // print(url);

     post.add({
      'title': texttitleController.text,
      'subtitle': texttitleController.text,
      'imageUrl': url,

    });
  }

  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('form'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: texttitleController,
              decoration: const InputDecoration(
                icon: const Icon(Icons.person),
                hintText: 'Title',
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: textsubtitleController,
              decoration: const InputDecoration(
                icon: const Icon(Icons.phone),
                hintText: 'description',
                labelText: 'Name',
              ),
            ),
            RaisedButton(
              child: Text(
                'upload image',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                getImage();
              },
            ),
            new Container(
                padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                child: new RaisedButton(
                    child: const Text('Submit'),
                    onPressed: (){
                      uploadFile();
                      Navigator.pop(context);
                    }
                )),
          ],
        ),
      ),
    );
  }
}
