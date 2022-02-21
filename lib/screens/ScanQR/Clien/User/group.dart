import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:qrscanar/Controller/var.dart';

class Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
            child: Card(
              child: Container(
                height: 50,
                child: Center(
                    child: group == ""
                        ? Text(
                            'Choose your team',
                            style: TextStyle(
                                color: colors,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        : Text(
                            group,
                            style: TextStyle(
                                color: colors,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )),
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        showPopover(
          context: context,
          transitionDuration: const Duration(milliseconds: 150),
          bodyBuilder: (context) => ListItems(),
          onPop: () => print('Popover was popped!'),
          direction: PopoverDirection.top,
          width: 200,
          height: 210,
          arrowHeight: 15,
          arrowWidth: 30,
        );
      },
    );
  }
}

class ListItems extends StatefulWidget {
  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  group = "AE";
                });
                Get.back();
              },
              child: Container(
                height: 50,
                color: colors.withOpacity(0.5),
                child: const Center(child: Text('AE')),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                group = "CR";

                Get.back();
              },
              child: Container(
                height: 50,
                color: colors.withOpacity(0.6),
                child: const Center(child: Text('CR')),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                group = "CC";

                Get.back();
              },
              child: Container(
                height: 50,
                color: colors.withOpacity(0.8),
                child: const Center(child: Text('CC')),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                group = "Digital";

                Get.back();
              },
              child: Container(
                height: 50,
                color: colors.withOpacity(0.8),
                child: const Center(child: Text('Digital')),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                group = "Logistics";

                Get.back();
              },
              child: Container(
                height: 50,
                color: colors.withOpacity(0.8),
                child: const Center(child: Text('Logistics')),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                group = "Secretaria";

                Get.back();
              },
              child: Container(
                height: 50,
                color: colors.withOpacity(0.8),
                child: const Center(child: Text('Secretaria')),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                group = "Bureau";

                Get.back();
              },
              child: Container(
                height: 50,
                color: colors.withOpacity(0.8),
                child: const Center(child: Text('Bureau')),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                group = "G1";

                Get.back();
              },
              child: Container(
                height: 50,
                color: colors.withOpacity(0.8),
                child: const Center(child: Text('G1')),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                group = "G2";

                Get.back();
              },
              child: Container(
                height: 50,
                color: colors.withOpacity(0.8),
                child: const Center(child: Text('G2')),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                group = "G3";

                Get.back();
              },
              child: Container(
                height: 50,
                color: colors.withOpacity(0.8),
                child: const Center(child: Text('G3')),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                group = "G4";

                Get.back();
              },
              child: Container(
                height: 50,
                color: colors.withOpacity(0.8),
                child: const Center(child: Text('G4')),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                group = "G5";

                Get.back();
              },
              child: Container(
                height: 50,
                color: colors.withOpacity(0.8),
                child: const Center(child: Text('G5')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
