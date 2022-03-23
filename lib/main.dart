// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:spa/parent.dart';
import 'package:spa/strings.dart';
var user;

void main() => runApp(MaterialApp(
      title: appName,
      theme: ThemeData(primarySwatch: Colors.green),
      home: SPA(user: user),
    ));
