void book(odoo, user, chairId, serviceId, date) async {
  await odoo.insert('salon.booking', {
    'name': user.name,
    'email': user.username,
    'chair_id': chairId,
    'services': [serviceId],
    'time': date,
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
  print(isReserved);
  return isReserved;
}
