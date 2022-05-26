import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:spa/parent.dart';
import 'package:spa/strings.dart';
import 'package:desktop_window/desktop_window.dart';

Future setWindowSize() async {
  await DesktopWindow.setMinWindowSize(const Size(360, 640));
  await DesktopWindow.setMaxWindowSize(const Size(360, 640));
}

var session = SessionManager();
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: appName,
    theme: ThemeData(primarySwatch: Colors.green),
    home: const SPA(
      user: null,
      odoo: null,
    ),
  ));
}
