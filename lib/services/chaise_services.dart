import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/pages/espace_personnel.dart';
import 'package:spa/parent.dart';

void ajouterChaise(int spaId, Odoo odoo) async {
  await odoo.connect(Credential("chahinosaiyan@gmail.com", "1272000Ch*"));
  odoo.insert('salon.chair', {'name': 'chair1', 'spa_id': spaId} );
  odoo.disconnect();
}