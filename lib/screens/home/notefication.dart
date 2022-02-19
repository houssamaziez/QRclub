import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Netification extends StatefulWidget {
  const Netification({Key? key}) : super(key: key);

  @override
  _NetificationState createState() => _NetificationState();
}

class _NetificationState extends State<Netification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Notification')
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Text(
            'No Data...',
          );
        } else {
          final posts = snapshot.data?.docs;

          return ListView.builder(
            itemCount: posts?.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: InkWell(
                    onTap: () {},
                    child: Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.notifications,
                          color: Colors.red,
                        ),
                        title: Text(posts![index]["title"]),
                        subtitle: Text(posts[index]["text"]),
                      ),
                    ),
                  ));
            },
          );
        }
      },
    ));
  }
}
