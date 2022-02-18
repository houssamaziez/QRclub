import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscanar/screens/ScanQR/Clien/profile.dart';

class AllMbr extends StatelessWidget {
  const AllMbr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.red,
              )),
          backgroundColor: Colors.white,
          title: const Text("All", style: TextStyle(color: Colors.red)),
          centerTitle: true,
          elevation: 0,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Allusers')
              .orderBy("point", descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Text(
                'No Data...',
              );
            } else {
              final posts = snapshot.data?.docs;
              print(posts?.length);

              return ListView.builder(
                itemCount: posts?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: InkWell(
                        onTap: () {
                          Get.to(Profile(
                            id: posts![index]["id"],
                          ));
                        },
                        child: Card(
                          child: ListTile(
                            trailing: Text(
                              posts![index]["point"].toString(),
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            leading: const Icon(
                              Icons.person,
                              color: Colors.red,
                            ),
                            title: Text(posts![index]["name"]),
                            subtitle: Text(posts![index]["id"]),
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
