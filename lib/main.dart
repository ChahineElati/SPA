import 'package:flutter/material.dart';
import 'package:spa/parent.dart';
import 'package:spa/strings.dart';

void main() => runApp(MaterialApp(
      title: appName,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const SPA(user: null),
    ));
