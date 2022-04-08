import 'package:odoo/odoo.dart';

void ajouterChaise(int spaId, Odoo odoo) async {
  odoo.insert('salon.chair', {'name': 'chair1', 'spa_id': spaId} );
}