import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_storage/get_storage.dart';

String textQr = "";

// ignore: prefer_typing_uninitialized_variables
var resultt;

GetStorage storg = GetStorage();
GetStorage Password = GetStorage();

GetStorage storgavatar = GetStorage();
Color colors = const Color(0xFF33665D);
String group = "";

late String urlL;
String version0 = "";
late String passwordadmine;
late bool connect = true;

final spinkit = SpinKitSpinningLines(
  color: colors,
);
