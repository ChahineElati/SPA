import 'package:odoo/odoo.dart';

Future<void> ajouterCentre(Odoo odoo, String nomCentre, String addresse) async {
  await odoo.insert('salon.centre', {
    'name': nomCentre,
    'address': addresse,
    'description': '',
  });
}

Future<int> getIdDernierCentre(odoo) async {
  var id = await odoo.query(
    from: 'salon.centre',
    select: ['id'],
    orderBy: 'id DESC',
    limit: 1,
  );
  return id[0]['id'];
}
