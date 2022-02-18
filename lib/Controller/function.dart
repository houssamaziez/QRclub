import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qrscanar/Controller/var.dart';

Future<void> addpoint({point, doc}) async {
  CollectionReference users =
      FirebaseFirestore.instance.collection('users').doc(doc).collection(doc);
  return users.doc(doc).update({
    'point': c + point,
  }).then((value) {
    c = 0;
    print("add data ");
  }).catchError((error) => print("Failed to add user: $error"));
}

Future<void> adduser({name, image, doc, point}) {
  CollectionReference users =
      FirebaseFirestore.instance.collection('users').doc(doc).collection(doc);
  return users
      .doc(doc)
      .set({
        'name': name,
        'image': "images/imageava.png",
        'id': doc,
        'point': point,
      })
      .then((value) => print("add data "))
      .catchError((error) => print("Failed to add user: $error"));
}

Future<void> adduserall({name, image, doc, point}) {
  CollectionReference users = FirebaseFirestore.instance.collection('Allusers');
  return users
      .doc(doc)
      .set({
        'name': name,
        'image': "images/imageava.png",
        'id': doc,
        'point': point,
      })
      .then((value) => print("add data "))
      .catchError((error) => print("Failed to add user: $error"));
}

Future<void> addpointAll({docd, point}) {
  CollectionReference users = FirebaseFirestore.instance.collection('Allusers');
  return users
      .doc(docd)
      .update({
        'point': point,
      })
      .then((value) => print("add data "))
      .catchError((error) => print("Failed to add user: $error"));
}

var c;
var haveuser;
getDocs({doc}) async {
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
  print(
      "____________________________________________________________________________________________________________________________________________");

  print(c.toString());
  print(
      "________________________________________________________________________________________________________________");
}

vrfiuser({doc}) async {
  var a;
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(doc)
      .collection(doc)
      .get();
  for (int i = 0; i < querySnapshot.docs.length; i++) {
    a = querySnapshot.docs[i].id;
  }
  haveuser = a;
  print("_________________________________________________________________");

  print(c.toString());
  print(
      "________________________________________________________________________________________________________________");
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
