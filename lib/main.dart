import 'package:flutter/material.dart';
import 'package:spa/parent.dart';
import 'package:spa/strings.dart';
import 'package:flutter_session/flutter_session.dart';

var session = FlutterSession();
void main() => runApp(MaterialApp(
  
  debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const SPA(user: null, odoo: null,),
    ));
