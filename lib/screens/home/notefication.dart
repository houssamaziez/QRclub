import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qrscanar/Controller/var.dart';

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
          .orderBy("class", descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        try {
          if (!snapshot.hasData) {
            return spinkit;
          } else {
            final posts = snapshot.data?.docs;

            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 2));
                setState(() {
                  setState(() {});
                });
              },
              child: ListView.builder(
                itemCount: posts?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: InkWell(
                        onTap: () {},
                        child: Card(
                          child: SizedBox(
                            child: ListTile(
                              leading: Icon(
                                Icons.notifications,
                                color: colors,
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                ),
                                child: Text(posts![index]["title"]),
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, bottom: 30),
                                child: Text(posts[index]["text"]),
                              ),
                              trailing: Text(posts[index]["date"].toString(),
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.grey)),
                            ),
                          ),
                        ),
                      ));
                },
              ),
            );
          }
        } catch (e) {
          return spinkit;
        }
      },
    ));
  }
}
