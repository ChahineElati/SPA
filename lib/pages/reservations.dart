// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/parent.dart';
import 'package:spa/services/user_services.dart';

class Reservations extends StatefulWidget {
  const Reservations({Key? key, required this.user, required this.odoo}) : super(key: key);
  final Odoo? odoo;
  final UserLoggedIn? user;

  @override
  State<Reservations> createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Mes Réservations'),
      ElevatedButton(
          onPressed: (() {
            odoo.disconnect();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> SPA(user: null, odoo: odoo)));
          }),
          child: Text('Disconnect'))
    ]);
  }
}
