import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/parent.dart';
import 'package:spa/services/user_services.dart';
import 'package:spa/strings.dart';
import 'package:desktop_window/desktop_window.dart';

Future setWindowSize() async {
  await DesktopWindow.setMinWindowSize(const Size(360, 640));
  await DesktopWindow.setMaxWindowSize(const Size(360, 640));
}

var session = SessionManager();
void main() async {
  Odoo odoo =
    Odoo(Connection(url: Url(Protocol.http, "192.168.0.110", 8069), db: 'SPA'));
    await odoo.connect(Credential("chahinosaiyan@gmail.com", "1272000Ch*"));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: appName,
    theme: ThemeData(primarySwatch: Colors.green),
    home: SPA(
      user: null,
      odoo: odoo,
    ),
  ));
}
