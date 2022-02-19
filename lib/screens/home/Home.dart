import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscanar/Controller/controller.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:qrscanar/screens/ScanQR/Clien/User/add_user.dart';
import 'package:qrscanar/screens/ScanQR/admin/admin.dart';
import 'package:qrscanar/screens/ScanQR/allmanmber/screenall.dart';
import 'package:qrscanar/screens/home/notefication.dart';

//  profile user
class Home extends StatefulWidget {
  final id;

  const Home({Key? key, this.id}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .collection(widget.id);
    var listwdget = [
      const AllMbr(),
      Netification(),
      profile(users: users),
    ];
    var title = ["All members", "Notification", "Profile"];
    final GlobalKey<ScaffoldState> _key = GlobalKey();

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            label: 'All members',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important_sharp),
            label: 'notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        onTap: (z) {
          setState(() {
            selectedIndex = z;
          });
          print(z);
        },
      ),
      key: _key,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title[selectedIndex],
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              _key.currentState?.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.red,
            )),
      ),
      backgroundColor: Colors.grey.shade100,
      body: listwdget[selectedIndex],
      drawer: Drawer(
        backgroundColor: Colors.grey.shade100,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red.shade300,
              ),
              child: const Text('Name Club'),
            ),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Colors.red,
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
                  color: Colors.red,
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
                  color: Colors.red,
                ),
                title: const Text('Admine'),
                onTap: () {
                  Get.defaultDialog(
                      title: "Password",
                      content: TextField(
                        onChanged: (val) {
                          if (val == "houssam") {
                            Get.to(Admin());
                          }
                        },
                      ));
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.38,
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
                  color: Colors.red,
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
    if (point > 60) {
      return const AssetImage("images/lvl5.gif");
    }
  }

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
                                      MediaQuery.of(context).size.height * 0.07,
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
                                            fontWeight: FontWeight.bold),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                // QR
                                qr(context: context, code: widget.id),
                                // ID
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
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
                                                  color:
                                                      const Color(0xFFFD5D5D),
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
                                const Text(
                                  "Coins",
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
    );
  }
}

qr({context, code}) {
  return QrImage(
    data: "${code} ",
    size: MediaQuery.of(context).size.height * 0.2,
    backgroundColor: Colors.white,
    foregroundColor: Color(0xFF000000),
  );
}
