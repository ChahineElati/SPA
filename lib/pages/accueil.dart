// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';

class Accueil extends StatefulWidget {
  final UserLoggedIn? user;

  Accueil({Key? key, required this.user}) : super(key: key);
  Odoo odoo = Odoo(Connection(url: Url(Protocol.http, "10.0.2.2", 8069), db: 'SPA'));

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {

  @override
  Widget build(BuildContext context) {
    return Text('bienvenu ${widget.user==null ? '' : widget.user?.username}');
  }
}
