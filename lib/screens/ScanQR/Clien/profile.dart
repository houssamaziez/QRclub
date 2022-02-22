import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:qrscanar/screens/ScanQR/Clien/User/add_user.dart';
import 'package:qrscanar/screens/ScanQR/admin/admin.dart';
import 'package:qrscanar/screens/ScanQR/allmanmber/screenall.dart';
import 'package:qrscanar/screens/home/Home.dart';

//  profile user
class Profile extends StatefulWidget {
  final id;

  const Profile({Key? key, this.id}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .collection(widget.id);
    final GlobalKey<ScaffoldState> _key = GlobalKey();
    return Scaffold(
      key: _key,
      appBar: AppBar(
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
      body: Center(
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
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                  ),
                                  //  NAME
                                  StreamBuilder<QuerySnapshot>(
                                    stream: users.snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.038,
                                              color: colors,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  // QR
                                  qr(context: context, code: widget.id),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),

                                  // Group
                                  StreamBuilder<QuerySnapshot>(
                                    stream: users.snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.024,
                                              color: colors,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }
                                    },
                                  ),

                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.04,
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
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
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
                                                    image:
                                                        newMethod(point: s))),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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

                    return CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                        child: Image.asset(resultt),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
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
                  Get.to(() => AllMbr());
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
                            if (val == passwordadmine) {
                              Get.to(Admin());
                            }
                          },
                          obscureText: true));
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    'Developed by Aziez Houssam Eddine',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                      onPressed: () {
                        launchURL();
                      },
                      child: const Text(
                        "contact",
                        style: TextStyle(fontSize: 10),
                      ))
                ],
              ),
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
}

qr({context, code}) {
  return QrImage(
    data: "${code}",
    size: MediaQuery.of(context).size.height * 0.2,
    backgroundColor: Colors.white,
    foregroundColor: Color(0xFF000000),
  );
}
// .where('id',isEqualTo: "1508")
