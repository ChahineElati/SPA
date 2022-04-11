import 'package:flutter/material.dart';
import 'package:spa/services/centre_card.dart';
import 'package:spa/services/service_services.dart';
import 'package:spa/services/user_services.dart';

import '../models/centre.dart';

class ListeCentres extends StatefulWidget {
  const ListeCentres({Key? key, required this.odoo}) : super(key: key);
  final odoo;

  @override
  State<ListeCentres> createState() => _ListeCentresState();
}

class _ListeCentresState extends State<ListeCentres> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Centre>>(
      future: getCentres(widget.odoo),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return centreCard(snapshot.data[index]);
          });
        } else {
          return const Center(
            child: CircularProgressIndicator());
        }
      },
    );
  }
}
