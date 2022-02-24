import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscanar/Controller/configapp.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:qrscanar/screens/ScanQR/Clien/User/add_user.dart';
import 'package:qrscanar/screens/ScanQR/admin/admin.dart';
import 'package:qrscanar/screens/ScanQR/allmanmber/screenall.dart';
import 'package:qrscanar/screens/home/notefication.dart';
import 'package:qrscanar/screens/updata/updata.dart';
// ignore: unused_import
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

goUrl({@required url}) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false);
  } else {
    throw 'Could not launch $url';
  }
}

//  profile user
class Home extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final id;

  const Home({Key? key, this.id}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  iduraccont() async {
    var version;
    var url;
    String pass;
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Admine').get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      setState(() async {
        passwordadmine = pass = querySnapshot.docs[0]["pass"];
        Password.write("Password", pass);
        print(pass + "jezjfzne fzejnfzejnf ");
        version0 = version = querySnapshot.docs[1]["version"];
        // version = null;
        urlL = url = querySnapshot.docs[1]["url"];
      });
    }

    print(passwordadmine + " ");
  }

  var selectedIndex = 0;
  var chnavter = false;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.code);
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void initState() {
    iduraccont();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    super.initState();
  }

  late bool conx;
  @override
  Widget build(BuildContext context) {
    if (_connectionStatus.toString() == "ConnectivityResult.mobile" ||
        _connectionStatus.toString() == "ConnectivityResult.wifi") {
      setState(() {
        conx = true;
      });
    } else {
      setState(() {
        conx = false;
      });
    }
    CollectionReference users = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .collection(widget.id);
    var listwdget = [
      const AllMbr(),
      const Netification(),
      profile(users: users),
    ];
    var title = ["All members", "Notification", "Profile"];
    final GlobalKey<ScaffoldState> _key = GlobalKey();
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined),
              label: 'All members',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notification_important_sharp),
              label: 'New',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: colors,
          unselectedItemColor: Colors.black,
          showSelectedLabels: false,
          onTap: (z) {
            setState(() {
              selectedIndex = z;
            });
          },
        ),
        key: _key,
        appBar: AppBar(
          flexibleSpace: conx == true
              ? Container()
              : Container(
                  height: 20,
                  child: Center(child: Text("No connection")),
                  color: Colors.red,
                ),
          centerTitle: true,
          title: Text(
            title[selectedIndex],
            style: TextStyle(color: colors, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                _key.currentState?.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: colors,
              )),
        ),
        backgroundColor: Colors.grey.shade100,
        body: listwdget[selectedIndex],
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/cov.png"), fit: BoxFit.contain),
                ),
                child: Text(''),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: colors,
                  ),
                  title: const Text('Home'),
                  onTap: () {
                    Get.off(Home(
                      id: storg.read("id"),
                    ));
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.group_outlined,
                    color: colors,
                  ),
                  title: const Text('All members'),
                  onTap: () {
                    Get.to(() => const AllMbr());
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.admin_panel_settings,
                    color: colors,
                  ),
                  title: const Text('Admine'),
                  onTap: () {
                    Get.defaultDialog(
                        title: "Password",
                        content: TextField(
                            onChanged: (val) {
                              if (val == Password.read("Password")) {
                                Get.offAll(const Admin());
                              }
                            },
                            obscureText: true));
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      'Developed by Aziez Houssam Eddine',
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    TextButton(
                        onPressed: () {
                          launchURL();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            "contact",
                            style: TextStyle(fontSize: 10),
                          ),
                        ))
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  launchURL1();
                },
                child: version0 != "1.2"
                    ? Card(
                        elevation: 7,
                        child: ListTile(
                            leading: Icon(
                              Icons.download,
                              color: colors,
                            ),
                            title: Text(
                              "Update",
                              style: TextStyle(
                                  color: colors,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    : Container(),
              ),
              Card(
                child: ListTile(
                  title: const Text('Log out'),
                  onTap: () async {
                    Get.offAll(AddUser());
                    storg.remove("id");
                  },
                  leading: Icon(
                    Icons.exit_to_app,
                    color: colors,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  var point;
  var groupp;
  var chngename = false;
  var chngenamegroupp = false;
  profile({users}) {
    return Center(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 30, left: 30, top: 60),
                    child: Card(
                        color: Colors.white,
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.62,
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                //  NAME
                                Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.12,
                                        ),
                                        StreamBuilder<QuerySnapshot>(
                                          stream: users.snapshots(),
                                          builder: (context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (!snapshot.hasData) {
                                              return const Text(
                                                'No Data...',
                                              );
                                            } else {
                                              final posts = snapshot.data?.docs;

                                              resultt = posts![0]["name"];

                                              return Text(
                                                resultt.toString(),
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.053,
                                                    color: colors,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                        right: 0,
                                        top: 0,
                                        child: IconButton(
                                            onPressed: () {
                                              Get.defaultDialog(
                                                  confirm: TextButton(
                                                      onPressed: () async {
                                                        // coll1 users
                                                        if (point == null) {
                                                        } else {
                                                          setState(() {
                                                            chngename = true;
                                                          });
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users')
                                                              .doc(storg
                                                                  .read("id"))
                                                              .collection(storg
                                                                  .read("id"))
                                                              .doc(storg
                                                                  .read("id"))
                                                              .update({
                                                            'name': point,
                                                          });

                                                          // coll1 All users

                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Allusers')
                                                              .doc(storg
                                                                  .read("id"))
                                                              .update({
                                                            'name': point,
                                                          });
                                                          setState(() {
                                                            chngename = false;
                                                          });
                                                          Get.back();
                                                        }
                                                      },
                                                      child: chngename == true
                                                          ? CircularProgressIndicator(
                                                              color: colors,
                                                            )
                                                          : Text(
                                                              "Confirm",
                                                              style: TextStyle(
                                                                  color:
                                                                      colors),
                                                            )),
                                                  title: 'Edit',
                                                  content: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 40,
                                                            left: 40,
                                                            top: 20),
                                                    child: TextField(
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4)),
                                                          borderSide:
                                                              BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      colors),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                          color: colors,
                                                          width: 5,
                                                        )),
                                                        hintText:
                                                            "Change your name",
                                                      ),
                                                      onChanged: (val) {
                                                        setState(() {
                                                          point = val;
                                                        });
                                                      },
                                                    ),
                                                  ));
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                            ))),
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                // QR
                                qr(context: context, code: widget.id),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.0,
                                ),

                                // Group
                                Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                        ),
                                        StreamBuilder<QuerySnapshot>(
                                          stream: users.snapshots(),
                                          builder: (context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (!snapshot.hasData) {
                                              return const Text(
                                                'No Data...',
                                              );
                                            } else {
                                              final posts = snapshot.data?.docs;

                                              resultt = posts![0]["group"];

                                              return Text(
                                                "Group : " + resultt.toString(),
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.024,
                                                    color: colors,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      right: 020,
                                      top: 0,
                                      child: IconButton(
                                          onPressed: () {
                                            Get.defaultDialog(
                                                confirm: TextButton(
                                                    onPressed: () async {
                                                      // coll1 users
                                                      if (groupp == null) {
                                                      } else {
                                                        setState(() {
                                                          chngenamegroupp =
                                                              true;
                                                        });
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('users')
                                                            .doc(storg
                                                                .read("id"))
                                                            .collection(storg
                                                                .read("id"))
                                                            .doc(storg
                                                                .read("id"))
                                                            .update({
                                                          'group': groupp,
                                                        });

                                                        // coll1 All users

                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Allusers')
                                                            .doc(storg
                                                                .read("id"))
                                                            .update({
                                                          'group': groupp,
                                                        });
                                                        setState(() {
                                                          chngenamegroupp =
                                                              false;
                                                        });
                                                        Get.back();
                                                      }
                                                    },
                                                    child: chngename == true
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 40,
                                                          left: 40,
                                                          top: 20),
                                                  child: TextField(
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4)),
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color: colors),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                        color: colors,
                                                        width: 5,
                                                      )),
                                                      hintText:
                                                          "Change your group ",
                                                    ),
                                                    onChanged: (val) {
                                                      setState(() {
                                                        groupp = val;
                                                      });
                                                    },
                                                  ),
                                                ));
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            size: 20,
                                          )),
                                    )
                                  ],
                                ),

                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.024,
                                ),
                                //  PONT
                                Center(
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.id)
                                        .collection(widget.id)
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Text(
                                          'No Data...',
                                        );
                                      } else {
                                        final posts = snapshot.data?.docs;

                                        var s = posts![0]["point"];
                                        // IMAGE POINT LVL

                                        return Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: newMethod(point: s))),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: Center(
                                            child: Text(
                                              s.toString(),
                                              style: TextStyle(
                                                  color: colors,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.04,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Text(
                                  "Coins",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: colors,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          // imag

          Positioned(
            top: MediaQuery.of(context).size.height * 0.02,
            left: 0,
            right: 0,
            child: StreamBuilder<QuerySnapshot>(
              stream: users.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text(
                    'No Data...',
                  );
                } else {
                  final posts = snapshot.data?.docs;

                  resultt = posts![0]["image"];

                  return Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 60,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                            child: chnavter == true
                                ? spinkit
                                : Image.asset(resultt),
                          ),
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
                                          overscroll.disallowIndicator();
                                          return true;
                                        },
                                        child: GridView.count(
                                          crossAxisCount: 2,
                                          children: List.generate(2, (index) {
                                            return Center(
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() async {
                                                    // coll1 users

                                                    setState(() {
                                                      chnavter = true;
                                                    });
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .doc(storg.read('id'))
                                                        .collection(
                                                            storg.read('id'))
                                                        .doc(storg.read('id'))
                                                        .update({
                                                      'image':
                                                          "images/avt${index.toString()}.png",
                                                    });

                                                    // coll1 All users

                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('Allusers')
                                                        .doc(storg.read('id'))
                                                        .update({
                                                      'image':
                                                          "images/avt${index.toString()}.png",
                                                    });
                                                    setState(() {
                                                      chnavter = false;
                                                    });
                                                    Get.back();
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 30,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      backgroundImage: AssetImage(
                                                          "images/avt$index.png"),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    index == 0
                                                        ? Text("Male")
                                                        : Text("Female")
                                                  ],
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
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

qr({context, code}) {
  return QrImage(
    data: "${code}",
    size: MediaQuery.of(context).size.height * 0.2,
    backgroundColor: Colors.white,
    foregroundColor: Color(0xFF000000),
  );
}

void launchURL() async {
  if (!await launch("https://linktr.ee/houssamaziez"))
    throw 'Could not launch https://linktr.ee/houssamaziez';
}
