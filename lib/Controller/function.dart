import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qrscanar/Controller/var.dart';

Future<void> addpoint({point, doc}) async {
  CollectionReference users =
      FirebaseFirestore.instance.collection('users').doc(doc).collection(doc);
  return users.doc(doc).update({
    'point': c + point,
  }).then((value) async {
    await addpointAll(doc: doc, point: c + point);
    c = 0;
    // ignore: invalid_return_type_for_catch_error, avoid_print
  }).catchError((error) => print("Failed to add user: $error"));
}

Future<void> addpointAll({point, doc}) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Allusers');

  return users.doc(doc).update({
    'point': point,
  }).then((value) {
    c = 0;
    // ignore: avoid_print
    print("add data ");
    // ignore: avoid_print, invalid_return_type_for_catch_error
  }).catchError((error) => print("Failed to add user: $error"));
}

Future<void> adduser({name, image, doc, point, group1}) {
  CollectionReference users =
      FirebaseFirestore.instance.collection('users').doc(doc).collection(doc);

  return users
      .doc(doc)
      .set({
        'name': name,
        'group': group1,
        'image': "images/avt$image.png",
        'id': doc,
        'point': point,
      })
      // ignore: avoid_print
      .then((value) => print("add data "))
      // ignore: avoid_print
      .catchError((error) => print("Failed to add user: $error"));
}

Future<void> adduserall({name, image, doc, point, group1}) {
  CollectionReference users = FirebaseFirestore.instance.collection('Allusers');
  return users
      .doc(doc)
      .set({
        'name': name,
        'group': group1,
        'image': "images/avt$image.png",
        'id': doc,
        'point': point,
      })
      // ignore: avoid_print
      .then((value) => print("add data "))
      // ignore: avoid_print
      .catchError((error) => print("Failed to add user: $error"));
}

// ignore: prefer_typing_uninitialized_variables
var c;
// ignore: prefer_typing_uninitialized_variables
getDocs({doc}) async {
  // ignore: prefer_typing_uninitialized_variables
  var a;
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(doc)
      .collection(doc)
      .get();
  for (int i = 0; i < querySnapshot.docs.length; i++) {
    a = querySnapshot.docs[i];
  }
  c = a["point"];
}

StreamBuilder<QuerySnapshot<Object?>> realtimedata({
  colaction,
}) {
  return StreamBuilder<QuerySnapshot>(
    stream: colaction.snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      final posts = snapshot.data?.docs;

      resultt = posts![0]["point"];

      return Text(resultt.toString());
    },
  );
}

iduraccont({doc}) async {
  // ignore: prefer_typing_uninitialized_variables
  var a;
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(doc)
      .collection(doc)
      .get();
  for (int i = 0; i < querySnapshot.docs.length; i++) {
    a = querySnapshot.docs[i].id;
  }
  return a;
}
