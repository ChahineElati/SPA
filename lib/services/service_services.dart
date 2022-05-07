import 'package:odoo/odoo.dart';
import 'package:spa/models/service.dart';

void addService(int id,Odoo odoo) async {
  var spa = await odoo.read('res.users', id);
  int spaId = spa!['personnel_centre'][0];
  odoo.insert('salon.service', {'name': 'service1', 'price': 24.9, 'time_taken': 30.5, 'spa_id': spaId});
}

  Future<List<Service>> getServices(int id, Odoo odoo) async {
    var fetchedServices = await odoo.query(from: 'salon.service', select: [], where: [['spa_id', '=', id]]);
    List<Service> services = [];
    for (var service in fetchedServices) {
      services.add(Service(service['name'], service['price'], service['time_taken']));
    } 
    return services;
  }
