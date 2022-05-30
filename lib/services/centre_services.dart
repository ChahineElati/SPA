import 'package:odoo/odoo.dart';
import 'package:spa/models/centre.dart';
import 'package:spa/strings.dart';

Future<void> ajouterCentre(
    Odoo odoo, String nomCentre, String addresse, int ratingId) async {
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
    Centre c = Centre(centre['name'], centre['address'], centre['description'],
        centre['id'], centre['avg_rating']);
    listeCentres.add(c);
  }
  return listeCentres;
}

Future<List<Centre>> getTop3Centres() async {
  List<String> centresIds;
  List<int> ids;
  List<Centre> listeCentres = <Centre>[];

  Odoo odoo = Odoo(Connection(url: Url(Protocol.http, host, 8069), db: 'SPA'));
  await odoo.connect(Credential("chahinosaiyan@gmail.com", "1272000Ch*"));

  List centres = await odoo.query(
      from: 'salon.centre', select: [], orderBy: 'avg_rating DESC', limit: 3);

  for (var centre in centres) {
    Centre c = Centre(centre['name'], centre['address'], centre['description'],
        centre['id'], centre['avg_rating']);
    listeCentres.add(c);
  }
  odoo.disconnect();
  return listeCentres;
}

Future<Centre> getCentreById(Odoo odoo, int centreId) async {
  var centre = await odoo.query(from: 'salon.centre', select: [], where: [
    ['id', '=', centreId]
  ]);
  Centre c = Centre(centre[0]['name'], centre[0]['address'],
      centre[0]['description'], centre[0]['id'], centre[0]['avg_rating']);

  return c;
}
