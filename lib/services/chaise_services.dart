import 'package:odoo/odoo.dart';

void ajouterChaise(int id, Odoo odoo) async {
  var spa = await odoo.read('res.users', id);
  int spaId = spa!['personnel_centre'][0];
  await odoo.insert('salon.chair', {'name': 'chair1', 'spa_id': spaId} );
}
