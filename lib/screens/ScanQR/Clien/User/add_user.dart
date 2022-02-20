import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscanar/Controller/function.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:qrscanar/screens/ScanQR/Clien/User/login.dart';
import 'package:qrscanar/screens/ScanQR/scan_qr.dart';

import '../../../home/Home.dart';

var id;

class AddUser extends StatefulWidget {
  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  void dispose() {
    storgavatar.write("avtr", indextimage);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  var islod = false;

  var reslt = "";
  var name = "";
  var indextimage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF33665D),
          onPressed: () async {
            if (name == "" && id == "") {
            } else {
              setState(() {
                islod = true;
              });
              var h = await iduraccont(doc: id);
              if (h == null) {
                await adduser(
                    doc: id, point: 0, name: name, image: indextimage);
                await adduserall(
                    doc: id, point: 0, name: name, image: indextimage);
                storg.write("id", id);

                Get.to(Home(
                  id: id,
                ));
              } else {
                Get.snackbar("Exapsion", "this is an existing accont");
              }
            }
            setState(() {
              islod = false;
            });
          },
          child: islod == true
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Icon(Icons.arrow_forward_ios),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Crearte Compte",
            style: TextStyle(color: colors, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.86,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.42,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("images/img2.png"),
                  ),

                  // add QR
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 40,
                      right: 40,
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.to(ScanQR());
                      },
                      child: Card(
                        elevation: 7,
                        child: ListTile(
                            leading: Icon(
                              Icons.qr_code_scanner_outlined,
                              color: colors,
                            ),
                            title: id == null
                                ? const Text("Add Your Code QR ")
                                : Text(" Your Code QR :" + id.toString())),
                      ),
                    ),
                  ),
                  textfild(title: "Name ", valu: name),
                  const SizedBox(
                    height: 20,
                  ),

                  //  add avatar

                  InkWell(
                    onTap: () {
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
                              crossAxisCount: 3,
                              children: List.generate(9, (index) {
                                return Center(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        Get.back();
                                        indextimage = index;

                                        print(indextimage);
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          AssetImage("images/avt$index.png"),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage:
                              AssetImage("images/avt$indextimage.png"),
                        ),
                        const Icon(Icons.add_a_photo),
                      ],
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Get.to(Login());
                      },
                      child: Text(
                        "i have an account",
                        style: TextStyle(color: colors),
                      )),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ));
  }

  Padding textfild({
    title,
    valu,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
      child: TextField(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: colors),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: colors,
            width: 5,
          )),
          hintText: title,
        ),
        onChanged: (val) {
          setState(() {
            name = val;
          });
        },
      ),
    );
  }
}
