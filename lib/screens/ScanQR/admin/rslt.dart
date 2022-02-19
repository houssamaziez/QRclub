import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscanar/Controller/function.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:qrscanar/main.dart';

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
        backgroundColor: Colors.red,
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
                height: MediaQuery.of(context).size.height,
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
                                                  0.03,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                  qr(context: context, code: widget.id),
                                  SelectableText(
                                    "id : " + widget.id,
                                    style: TextStyle(
                                        color: Color(0xFFFD5D5D),
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.id)
                                        .collection(widget.id)
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      final posts = snapshot.data?.docs;
                                      ponitdebut = posts![0]["point"];
                                      if (!snapshot.hasData) {
                                        return const Text(
                                          'No Data...',
                                        );
                                      } else {
                                        return Text(
                                          "point : " + ponitdebut.toString(),
                                          style: const TextStyle(
                                              color: Color(0xFFFD5D5D),
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.11,
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