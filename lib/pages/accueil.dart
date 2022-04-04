// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';

class Accueil extends StatefulWidget {
  final UserLoggedIn? user;

  const Accueil({Key? key, required this.user}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return Text('bienvenu ${widget.user == null ? '' : widget.user?.name}');
  }
}