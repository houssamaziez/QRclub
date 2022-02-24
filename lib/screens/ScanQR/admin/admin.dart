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
  var addpointleading = false;
  var deleltleading = false;
  var chng = false;

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
                itemBuilder: (BuildContext context, int indexLIST) {
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
                                                setState(() {
                                                  addpointleading = true;
                                                });
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(
                                                        posts![indexLIST]["id"])
                                                    .collection(
                                                        posts[indexLIST]["id"])
                                                    .doc(posts[indexLIST]["id"])
                                                    .update({
                                                  'point': int.parse(point),
                                                });

                                                // coll1 All users

                                                await FirebaseFirestore.instance
                                                    .collection('Allusers')
                                                    .doc(posts[indexLIST]["id"])
                                                    .update({
                                                  'point': int.parse(point),
                                                });
                                                setState(() {
                                                  addpointleading = false;
                                                });
                                                Get.back();
                                              }
                                            },
                                            child: addpointleading == true
                                                ? CircularProgressIndicator(
                                                    color: colors,
                                                  )
                                                : Text(
                                                    "Confirm",
                                                    style: TextStyle(
                                                        color: colors),
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
                                              hintText: posts![indexLIST]
                                                      ["point"]
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
                                          posts![indexLIST]["point"].toString(),
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
                              leading: Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 25,
                                    child: chng == true
                                        ? spinkit
                                        : Image.asset(
                                            posts[indexLIST]["image"]),
                                  ),
                                  Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: IconButton(
                                          onPressed: () {
                                            Get.defaultDialog(
                                              title: "Avatar",
                                              content: Container(
                                                height: 200,
                                                child: NotificationListener<
                                                    OverscrollIndicatorNotification>(
                                                  onNotification: (overscroll) {
                                                    overscroll
                                                        .disallowIndicator();
                                                    return true;
                                                  },
                                                  child: GridView.count(
                                                    crossAxisCount: 3,
                                                    children: List.generate(9,
                                                        (indexx) {
                                                      return Center(
                                                        child: InkWell(
                                                          onTap: () async {
                                                            setState(() async {
                                                              // coll1 users

                                                              setState(() {
                                                                chng = true;
                                                              });
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'users')
                                                                  .doc(posts[indexLIST]
                                                                          ["id"]
                                                                      .toString())
                                                                  .collection(posts[
                                                                              indexLIST]
                                                                          ["id"]
                                                                      .toString())
                                                                  .doc(posts[indexLIST]
                                                                          ["id"]
                                                                      .toString())
                                                                  .update({
                                                                'image':
                                                                    "images/avt$indexx.png",
                                                              });

                                                              // coll1 All users

                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Allusers')
                                                                  .doc(posts[
                                                                          indexLIST]
                                                                      ["id"])
                                                                  .update({
                                                                'image':
                                                                    "images/avt$indexx.png",
                                                              });
                                                              setState(() {
                                                                chng = false;
                                                              });
                                                              Get.back();
                                                            });
                                                          },
                                                          child: chng == true
                                                              ? spinkit
                                                              : CircleAvatar(
                                                                  radius: 30,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  backgroundImage:
                                                                      AssetImage(
                                                                          "images/avt$indexx.png"),
                                                                ),
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.edit)))
                                ],
                              ),
                              title: Text(posts[indexLIST]["name"]),
                              subtitle: Text(posts[indexLIST]["id"]),
                            ),
                          ),
                          storg.read("id") == posts[indexLIST]["id"]
                              ? Container()
                              : IconButton(
                                  onPressed: () async {
                                    Get.defaultDialog(
                                        confirm: TextButton(
                                            onPressed: () async {
                                              setState(() {
                                                deleltleading = true;
                                              });
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(posts[indexLIST]["id"])
                                                  .collection(
                                                      posts[indexLIST]["id"])
                                                  .doc(posts[indexLIST]["id"])
                                                  .delete();
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(posts[indexLIST]["id"])
                                                  .delete();

                                              await FirebaseFirestore.instance
                                                  .collection('Allusers')
                                                  .doc(posts[indexLIST]["id"])
                                                  .delete();
                                              setState(() {
                                                deleltleading = false;
                                              });
                                              Get.back();
                                            },
                                            child: deleltleading == true
                                                ? CircularProgressIndicator(
                                                    color: colors,
                                                  )
                                                : Text(
                                                    "Confirm",
                                                    style: TextStyle(
                                                        color: colors),
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
