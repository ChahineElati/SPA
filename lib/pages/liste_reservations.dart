// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';

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
    return Column(children: const [
      Text('Mes Réservations'),
    ]);
  }
}
