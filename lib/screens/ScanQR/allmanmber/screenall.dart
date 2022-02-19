import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscanar/screens/ScanQR/Clien/profile.dart';

class AllMbr extends StatelessWidget {
  const AllMbr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //       onPressed: () {
        //         Get.back();
        //       },
        //       icon: const Icon(
        //         Icons.arrow_back_ios,
        //         color: Colors.red,
        //       )),
        //   backgroundColor: Colors.white,
        //   title: const Text("All", style: TextStyle(color: Colors.red)),
        //   centerTitle: true,
        //   elevation: 0,
        // ),
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

          return ListView.builder(
            itemCount: posts?.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: InkWell(
                    onTap: () {
                      Get.to(Profile(
                        id: posts![index]["id"],
                      ));
                    },
                    child: Card(
                      child: ListTile(
                        trailing: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: newMethod(
                                      point: posts![index]["point"]))),
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Center(
                            child: Text(
                              posts[index]["point"].toString(),
                              style: TextStyle(
                                  color: const Color(0xFFFD5D5D),
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.022,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: Image.asset(posts[index]["image"]),
                        ),
                        title: Text(posts[index]["name"]),
                        subtitle: Text(posts[index]["id"]),
                      ),
                    ),
                  ));
            },
          );
        }
      },
    ));
  }

  newMethod({point}) {
    if (point <= 10) {
      return AssetImage("images/lvl1.gif");
    }
    if (point > 10 && point <= 20) {
      return AssetImage("images/lvl2.gif");
    }
    if (point > 20 && point <= 40) {
      return AssetImage("images/lvl3.gif");
    }
    if (point > 40 && point <= 60) {
      return AssetImage("images/lvl4.gif");
    }
    if (point > 60) {
      return AssetImage("images/lvl5.gif");
    }
  }
}
