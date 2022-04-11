import 'package:odoo/odoo.dart';
import 'package:spa/models/centre.dart';

Future<List<Centre>> getCentres(Odoo odoo) async {
  List<Centre> listeCentres = <Centre>[];
  var centres = await odoo.query(from: 'salon.centre', select: []);
  for (var centre in centres) {
    Centre c = Centre(centre['name'], centre['address'], centre['description']);
    listeCentres.add(c);
  }
  return listeCentres;
}
