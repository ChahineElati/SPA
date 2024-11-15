// ignore_for_file: avoid_print

import 'package:odoo/odoo.dart';

void book(odoo, user, chairId, servicesIds, date, double prixTotal,
    int centreId) async {
  await odoo.insert('salon.booking', {
    'name': user.name,
    'email': user.username,
    'chair_id': chairId,
    'services': servicesIds,
    'time': date,
    'spa_id': centreId
  });
}

Future<bool> verifierTempsReservation(
    odoo, chairId, String date, String time) async {
  var spaReservations = await odoo.query(from: 'salon.booking', select: [
    'chair_id',
    'time'
  ], where: [
    ['chair_id', '=', chairId]
  ]);
  bool isReserved = false;

  for (var reservation in spaReservations) {
    String reservationDate = reservation['time'].split(' ')[0];
    String reservationTime = reservation['time'].split(' ')[1];
    print(reservationTime);
    print(time);
    if (reservationDate == date && reservationTime == '$time:00') {
      isReserved = true;
      break;
    } else {
      isReserved = false;
    }
  }
  return isReserved;
}

void approve(Odoo odoo) async {
  int id = await odoo
      .query(from: 'salon.booking', select: ['id'], orderBy: 'id DESC')
      .then((value) => value[0]['id']);
  odoo.update('salon.booking', id, {'state': 'approved'});
  print(id);
}

Future<List> showReservationsByUser(Odoo odoo, UserLoggedIn user) async {
  List list = [];

  List reservations = await odoo.query(from: 'salon.booking', select: [
    'name',
    'services',
    'time'
  ], where: [
    ['email', '=', user.username]
  ]);

  for (var reservation in reservations) {
    Map map = {};
    List li = [];
    List services = await odoo.query(from: 'salon.service', select: []);
    for (var service in services) {
      if (reservation['services'].contains(service['id'])) {
        li.add(service['name']);
      }
    }

    map = {'reservation': reservation, 'services': li};
    list.add(map);
  }

  return list;
}
