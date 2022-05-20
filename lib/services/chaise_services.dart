import 'package:odoo/odoo.dart';
import 'package:spa/models/chair.dart';

void ajouterChaise(int id, Odoo odoo) async {
  var spa = await odoo.read('res.users', id);
  int spaId = spa!['personnel_centre'][0];
  await odoo.insert('salon.chair', {'name': 'chair1', 'spa_id': spaId});
}

Future<List> getchairsBySpaId(int id, Odoo odoo) async {
  List listChairs;
  var chairs = await odoo.query(from: 'salon.chair', select: [
    'id',
    'name'
  ], where: [
    ['spa_id', '=', id]
  ]);
  listChairs = chairs.map((value) => Chair(value['id'], value['name'])).toList();
  return listChairs;
}