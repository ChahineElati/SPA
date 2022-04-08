import 'package:odoo/odoo.dart';
import 'package:spa/models/centre.dart';

Future<List<Centre>> getCentres(Odoo odoo) async {
  List<Centre> listeCentres = <Centre>[];
  var centres = await odoo.query(from: 'res.users', select: [], where: [
    ['user_salon_active', '=', true]
  ]);
  for (var centre in centres) {
    Centre c = Centre(centre['name']);
    listeCentres.add(c);
  }
  return listeCentres;
}
