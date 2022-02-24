import 'package:flutter/material.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:url_launcher/url_launcher.dart';

class Updata extends StatelessWidget {
  const Updata({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 40,
              right: 40,
            ),
            child: InkWell(
              onTap: () {
                launchURL1();
              },
              child: Card(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

launchURL1() async {
  if (!await launch(urlL))
    throw 'Could not launch https://linktr.ee/houssamaziez';
}
