import 'package:odoo/odoo.dart';
import 'package:spa/models/centre.dart';

Future<void> ajouterCentre(Odoo odoo, String nomCentre, String addresse, int ratingId) async {
  await odoo.insert('salon.centre', {
    'name': nomCentre,
    'address': addresse,
    'description': '',
    'salon_rating': ratingId,
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

Future<List<Centre>> getCentres(Odoo odoo) async {
  List<Centre> listeCentres = <Centre>[];
  var centres = await odoo.query(from: 'salon.centre', select: []);
  for (var centre in centres) {
    Centre c = Centre(centre['name'], centre['address'], centre['description'], centre['id']);
    listeCentres.add(c);
  }
  return listeCentres;
}

Future<List<Centre>> getTop3Centres(Odoo odoo) async {

  List<dynamic> centreIds = await odoo.query(from: 'salon.rating', select: [], orderBy: '');
  return [];
}