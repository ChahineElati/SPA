import 'package:odoo/odoo.dart';
import 'package:spa/models/centre.dart';

Future<List<Centre>> getCentres(Odoo odoo) async {
  List<Centre> listeCentres = <Centre>[];
  var centres = await odoo.query(from: 'salon.centre', select: []);
  for (var centre in centres) {
    Centre c = Centre(centre['name'], centre['address'], centre['description'], centre['id']);
    listeCentres.add(c);
  }
  return listeCentres;
}

void addService(int id,Odoo odoo) async {
  var spa = await odoo.read('res.users', id);
  int spaId = spa!['personnel_centre'][0];
  odoo.insert('salon.service', {'name': 'service1', 'spa_id': spaId});
}

  Future<List> getServices(int id, Odoo odoo) async {
    var chairsList = await odoo.query(from: 'salon.service', select: [], where: [['spa_id', '=', id]]);
    return chairsList;
  }
