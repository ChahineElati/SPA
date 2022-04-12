import 'package:flutter/material.dart';
import 'package:spa/pages/informations_centre.dart';

Widget centreCard(context, centre, odoo) {

  return Card(
    child: Column(children: [
      ListTile(
        title: Text(centre.nom,
            style:
                const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        subtitle: Text(centre.addresse.toString()),
      ),
      TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InformationsCentre(centre: centre, odoo: odoo)));
          },
          child: Text(
            'Voir Plus',
            style: TextStyle(color: Colors.grey.shade700, fontSize: 20.0),
          )),
    ]),
  );
}
