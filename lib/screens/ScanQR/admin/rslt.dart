import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscanar/Controller/function.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:qrscanar/main.dart';
import 'package:qrscanar/screens/ScanQR/admin/screen_add_points.dart';

import 'admin.dart';

//  profile user
class Rslt extends StatefulWidget {
  final id;

  Rslt({Key? key, this.id}) : super(key: key);

  @override
  State<Rslt> createState() => _RsltState();
}

class _RsltState extends State<Rslt> {
  var islod = false;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .collection(widget.id);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors,
        child: islod == true
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                "+" + point.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
        onPressed: () async {
          if (islod == false) {
            setState(() {
              islod = true;
            });

            await getDocs(doc: widget.id);
            await addpoint(doc: widget.id, point: point);
            setState(() {
              islod = false;
            });
            Get.offAll(Admin());
          } else {
            print('waiting');
          }
        },
      ),
      backgroundColor: Colors.red.shade50,
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
    );
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

qr({context, code}) {
  return QrImage(
    data: "${code} ",
    size: MediaQuery.of(context).size.height * 0.2,
    backgroundColor: Colors.white,
    foregroundColor: Color(0xFF000000),
  );
}
// .where('id',isEqualTo: "1508")