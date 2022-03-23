// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/parent.dart';

class Reservations extends StatelessWidget {
  const Reservations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Odoo odoo = Odoo(
        Connection(url: Url(Protocol.http, "192.168.0.103", 8069), db: 'SPA'));
    return Column(children: [
      Text('Mes Réservations'),
      ElevatedButton(
          onPressed: (() {
            odoo.disconnect();
            Navigator.push(context, MaterialPageRoute(builder: (context)=> SPA(user: null)));
          }),
          child: Text('Disconnect'))
    ]);
  }
}
