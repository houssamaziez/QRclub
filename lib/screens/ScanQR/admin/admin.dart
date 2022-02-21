import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:qrscanar/screens/ScanQR/admin/screen_add_notf.dart';
import 'package:qrscanar/screens/ScanQR/admin/screen_add_points.dart';
import 'package:qrscanar/screens/home/Home.dart';

// ignore: must_be_immutable
class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

var ponitdebut;
var notification = "";
var titlenot = "";

class _AdminState extends State<Admin> {
  var msgController = TextEditingController();
  var msgController2 = TextEditingController();
  var islod = false;
  var point;

  // ignore: prefer_typing_uninitialized_variables
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.off(Home(
                id: storg.read("id"),
              ));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: colors,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Admine",
            style: TextStyle(color: colors),
          ),
          centerTitle: true,
        ),
        floatingActionButton: _getFAB(),
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
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: Stack(
                        children: [
                          Card(
                            child: ListTile(
                              trailing: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: InkWell(
                                  onTap: () {
                                    Get.defaultDialog(
                                        confirm: TextButton(
                                            onPressed: () async {
                                              // coll1 users
                                              if (point == null) {
                                              } else {
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(posts![index]["id"])
                                                    .collection(
                                                        posts[index]["id"])
                                                    .doc(posts[index]["id"])
                                                    .update({
                                                  'point': int.parse(point),
                                                });

                                                // coll1 All users

                                                await FirebaseFirestore.instance
                                                    .collection('Allusers')
                                                    .doc(posts[index]["id"])
                                                    .update({
                                                  'point': int.parse(point),
                                                });
                                                Get.back();
                                              }
                                            },
                                            child: Text(
                                              "Confirm",
                                              style: TextStyle(color: colors),
                                            )),
                                        title: 'Edit',
                                        content: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 40, left: 40, top: 20),
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4)),
                                                borderSide: BorderSide(
                                                    width: 1, color: colors),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                color: colors,
                                                width: 5,
                                              )),
                                              hintText: posts![index]["point"]
                                                  .toString(),
                                            ),
                                            onChanged: (val) {
                                              setState(() {
                                                point = val;
                                              });
                                            },
                                          ),
                                        ));
                                  },
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Text(
                                          posts![index]["point"].toString(),
                                          style: TextStyle(
                                              color: colors,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.022,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      //  edite point
                                      const Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Icon(
                                          Icons.mode_edit,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                      )
                                    ],
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
                          storg.read("id") == posts[index]["id"]
                              ? Container()
                              : IconButton(
                                  onPressed: () async {
                                    Get.defaultDialog(
                                        confirm: TextButton(
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(posts[index]["id"])
                                                  .collection(
                                                      posts[index]["id"])
                                                  .doc(posts[index]["id"])
                                                  .delete();
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(posts[index]["id"])
                                                  .delete();

                                              await FirebaseFirestore.instance
                                                  .collection('Allusers')
                                                  .doc(posts[index]["id"])
                                                  .delete();
                                              Get.back();
                                            },
                                            child: Text(
                                              "Confirm",
                                              style: TextStyle(color: colors),
                                            )),
                                        title: 'Delete',
                                        content: const Text(
                                            "Do you want to delete this person"));
                                  },
                                  icon: Row(
                                    children: [
                                      Icon(Icons.delete_forever, color: colors),
                                    ],
                                  )),
                        ],
                      ));
                },
              );
            }
          },
        ));
  }

// button bottm
  Widget _getFAB() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(size: 22),
      backgroundColor: colors,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
            child: const Icon(Icons.qr_code_scanner),
            backgroundColor: colors,
            onTap: () {
              Get.to(AddPoint());
            },
            label: 'Add Points',
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: colors),
        // FAB 2
        SpeedDialChild(
            child: const Icon(Icons.notification_add),
            backgroundColor: colors,
            onTap: () {
              setState(() {
                Get.to(const AddNotf());
              });
            },
            label: 'Add notification',
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: colors)
      ],
    );
  }
}
