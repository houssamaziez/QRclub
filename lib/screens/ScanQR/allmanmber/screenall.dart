import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:qrscanar/screens/ScanQR/Clien/profile.dart';
import 'package:qrscanar/screens/home/Home.dart';

class AllMbr extends StatefulWidget {
  const AllMbr({Key? key}) : super(key: key);

  @override
  State<AllMbr> createState() => _AllMbrState();
}

class _AllMbrState extends State<AllMbr> {
  var x;
  @override
  Widget build(BuildContext context) {
    print(x);
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Allusers')
          .orderBy("point", descending: true)
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
                setState(() {});
              },
              child: ListView.builder(
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
                        child: Stack(
                          children: [
                            Card(
                              child: Container(
                                height: 70,
                                child: ListTile(
                                  trailing: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: newMethod(
                                                point: posts![index]
                                                    ["point"]))),
                                    height: double.infinity,
                                    width: MediaQuery.of(context).size.width *
                                        0.26,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("     "),
                                        Spacer(),
                                        Center(
                                          child: Text(
                                            posts[index]["point"].toString(),
                                            style: TextStyle(
                                                color: colors,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "SC",
                                          style: TextStyle(
                                              color: colors,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.033,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 25,
                                    child: Image.asset(posts[index]["image"]),
                                  ),
                                  title: Text(posts[index]["name"]),
                                  subtitle: Text(posts[index]["group"]),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 50, right: 7),
                              child: CircleAvatar(
                                backgroundColor: colors,
                                radius: 14,
                                child: Text(
                                  (index + 1).toString(),
                                ),
                              ),
                            ),
                          ],
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

  newMethod({point}) {
    if (point <= 10) {
      return const AssetImage("images/lvl1.gif");
    }
    if (point > 10 && point <= 20) {
      return const AssetImage("images/lvl2.gif");
    }
    if (point > 20 && point <= 40) {
      return const AssetImage("images/lvl3.gif");
    }
    if (point > 40 && point <= 60) {
      return const AssetImage("images/lvl4.gif");
    }
    if (point > 60 && point <= 80) {
      return const AssetImage("images/lvl5.gif");
    }
    if (point > 80) {
      return const AssetImage("images/lvl6.gif");
    }
  }
}
