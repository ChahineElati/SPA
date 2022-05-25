import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:spa/parent.dart';
import 'package:spa/strings.dart';

var session = SessionManager();
void main() => runApp(MaterialApp(
  
  debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const SPA(user: null, odoo: null,),
    ));
