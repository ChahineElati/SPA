void book(odoo, user, chairId, servicesIds, date, double prixTotal) async {
  await odoo.insert('salon.booking', {
    'name': user.name,
    'email': user.username,
    'chair_id': chairId,
    'services': servicesIds,
    'time': date,
    'state': 'approved',
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
    if (reservationDate == date && reservationTime == '$time:00') {
      isReserved = true;
    } else {
      isReserved = false;
    }
  }
  return isReserved;
}
