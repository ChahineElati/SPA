import 'package:flutter/material.dart';
import 'package:spa/pages/informations_centre.dart';
import 'package:spa/services/rating_service.dart';

import '../main.dart';

Widget centreCard(context, centre, odoo, user) {

  return Card(
    child: Column(children: [
      ListTile(
        title: Text(centre.nom,
            style:
                const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        subtitle: Text(centre.addresse.toString()),
      ),
      TextButton(
          onPressed: () async {
            bool isRated = await checkIfrated(odoo, user.uid, centre.id);
            await session.set('isRated', isRated);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InformationsCentre(centre: centre, odoo: odoo, user: user)));
          },
          child: Text(
            'Voir Plus',
            style: TextStyle(color: Colors.grey.shade700, fontSize: 20.0),
          )),
    ]),
  );
}
