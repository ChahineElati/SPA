import 'package:flutter/material.dart';

Widget centreCard(centre) {
  return Card(
    child: Column(children: [
      ListTile(
        title: Text(centre.nom,
            style:
                const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                subtitle: Text(centre.addresse.toString()),
      ),
      TextButton(
          onPressed: () {},
          child: Text(
            'Voir Plus',
            style: TextStyle(color: Colors.grey.shade700, fontSize: 20.0),
          )),
    ]),
  );
}
