import 'package:flutter/material.dart';
import 'package:spa/pages/informations_centre.dart';
import 'package:spa/services/rating_service.dart';
import 'package:spa/strings.dart';

import '../main.dart';
import 'dart:math';


Widget centreCard(context, centre, odoo, user) {
  int randomIndex = Random().nextInt(spaImages.length);
  return Card(
    child: Column(children: [
      Container(
          height: 100,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(spaImages[randomIndex]), fit: BoxFit.cover),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ))),
      ListTile(
        title: Text(centre.nom,
            style:
                const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        subtitle: Text(centre.addresse.toString()),
      ),
      TextButton(
          onPressed: () async {
            if (user != null) {
              bool isRated = await checkIfrated(odoo, user.uid, centre.id);
              session.set('isRated', isRated);
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InformationsCentre(
                        centre: centre, odoo: odoo, user: user, image: randomIndex)));
          },
          child: Text(
            'Voir Plus',
            style: TextStyle(color: Colors.grey.shade700, fontSize: 20.0),
          )),
    ]),
  );
}
