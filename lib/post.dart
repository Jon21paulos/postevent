
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'form.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  CollectionReference post =
  FirebaseFirestore.instance.collection('post');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('post event'),
      ),
      body: Center(
        child: StreamBuilder(
            stream: post.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Loading'));
              }
              return ListView(
                children: snapshot.data!.docs.map((post) {
                  return Center(
                    child: ListTile(
                      leading:Image.network(post['imageUrl']),
                      title: Text(post['title']),
                      subtitle: Text(post['subtitle']),

                      onLongPress: () {
                        post.reference.delete();
                      },
                    ),
                  );
                }).toList(),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 8.0,
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => form()),
            );
          }
      ),
    );
  }
}


