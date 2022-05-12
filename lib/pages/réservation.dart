import 'package:flutter/material.dart';
import 'package:spa/services/book.dart';
import 'package:spa/services/user_services.dart';

class Reservation extends StatefulWidget {
  const Reservation({Key? key, required this.odoo}) : super(key: key);
  final odoo;
  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réservation'),
        centerTitle: true,
        backgroundColor: const Color(0xff008a00),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [Text('Choisir la place:'),
        ElevatedButton(onPressed: (){book(widget.odoo);}, child: Text('réserver'))],
      ),
    );
  }
}
