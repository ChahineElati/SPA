// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/services/user_services.dart';

class Accueil extends StatefulWidget {
  final UserLoggedIn? user;
  final Odoo? odoo;
  const Accueil({Key? key, required this.user, required this.odoo})
      : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('bienvenu ${widget.user == null ? '' : widget.user?.name}'),
        ElevatedButton(onPressed: () {
          sendCode('aaaa', widget.user!.username);
        }, child: Text('sign in')),
      ],
    );
  }
}