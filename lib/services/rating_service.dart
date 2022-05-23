import 'package:odoo/odoo.dart';

void updateRating(Odoo odoo, centreId, rating, userId) async {
  var fetchedRating =
      await odoo.query(from: 'salon.rating', select: [], where: [
    ['spa_id', '=', centreId]
  ]);

  List list = fetchedRating[0]['user_id'];
  list.add(userId);
  switch (rating) {
    case 1:
      odoo.update('salon.rating', fetchedRating[0]['id'],
          {'star1': fetchedRating[0]['star1'] + 1, 'user_id': list});
      break;
    case 2:
      odoo.update('salon.rating', fetchedRating[0]['id'],
          {'star2': fetchedRating[0]['star2'] + 1, 'user_id': list});
      break;
    case 3:
      odoo.update('salon.rating', fetchedRating[0]['id'],
          {'star3': fetchedRating[0]['star3'] + 1, 'user_id': list});
      break;
    case 4:
      odoo.update('salon.rating', fetchedRating[0]['id'],
          {'star4': fetchedRating[0]['star4'] + 1, 'user_id': list});
      break;
    case 5:
      odoo.update('salon.rating', fetchedRating[0]['id'],
          {'star5': fetchedRating[0]['star5'] + 1, 'user_id': list});
      break;
    default:
  }
}

Future<bool> checkIfrated(Odoo odoo, userId, centreId) async {
  List usersIds = await odoo.query(from: 'salon.rating', select: [], where: [
    ['spa_id', '=', centreId]
  ]).then((value) => value[0]['user_id']);
  print(usersIds);
  if (usersIds.contains(userId)) {
    print(true);
    return true;
  } else {
    print(false);
    return false;
  }
}
