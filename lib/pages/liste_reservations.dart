// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/services/book.dart';
import 'package:spa/services/service_services.dart';

class Reservations extends StatefulWidget {
  const Reservations({Key? key, required this.user, required this.odoo})
      : super(key: key);
  final Odoo? odoo;
  final UserLoggedIn? user;

  @override
  State<Reservations> createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  List reservations = [];
  List services = [];

  @override
  void initState() {
    showReservationsByUser(widget.odoo!, widget.user!).then((value) {
      setState(() {
        reservations = value;
      });
    });
    // getServicesByIdsList(widget.odoo!, reservations[index]['services']).then((value) {
    //       setState(() {
    //         services = value;
    //       });
    //     });
    print(reservations);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return reservations.isNotEmpty
        ? Column(
            children: [
              Row(
                children: const [
                  Expanded(
                      child: Center(
                          child: Text(
                    "Services",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ))),
                  Expanded(
                      child: Center(
                          child: Text(
                    'Date de réservation',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )))
                ],
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: reservations.length,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        ListTile(
                            title: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    reservations[index]['services'].length,
                                itemBuilder: ((context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.purpleAccent[700],
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          reservations[index]['services'][i],
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );
                                })),
                            trailing: Text(
                              reservations[index]['reservation']['time'],
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )),
                        Divider(),
                      ],
                    );
                  })),
            ],
          )
        : Center(
            child: Text(
            'Aucune Réservation',
            style: TextStyle(fontWeight: FontWeight.w600),
          ));
  }
}
