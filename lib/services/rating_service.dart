import 'package:odoo/odoo.dart';

void updateRating(Odoo odoo, centreId, rating, userId) async {
  var fetchedRating =
      await odoo.query(from: 'salon.rating', select: [], where: [
    ['spa_id', '=', centreId]
  ]);

  List fetchedUser = await odoo.query(from: 'res.users', select: [], where: [
    ['id', '=', userId]
  ]);

  Set<int> li = Set<int>.from(fetchedUser[0]['ratings']);
  li.add(fetchedRating[0]['id']);
  print('type: $li');

  List list = fetchedRating[0]['user_id'];
  list.add(userId);
  switch (rating) {
    case 1:
      odoo.update('salon.rating', fetchedRating[0]['id'], {
        'star1': fetchedRating[0]['star1'] + 1,
        'user_id': list,
      });
      odoo.update('res.users', userId, {'ratings': li.toList()});
      break;
    case 2:
      odoo.update('salon.rating', fetchedRating[0]['id'],
          {'star2': fetchedRating[0]['star2'] + 1, 'user_id': list});
          odoo.update('res.users', userId, {'ratings': li.toList()});
      break;
    case 3:
      odoo.update('salon.rating', fetchedRating[0]['id'],
          {'star3': fetchedRating[0]['star3'] + 1, 'user_id': list});
          odoo.update('res.users', userId, {'ratings': li.toList()});
      break;
    case 4:
      odoo.update('salon.rating', fetchedRating[0]['id'],
          {'star4': fetchedRating[0]['star4'] + 1, 'user_id': list});
          odoo.update('res.users', userId, {'ratings': li.toList()});
      break;
    case 5:
      odoo.update('salon.rating', fetchedRating[0]['id'],
          {'star5': fetchedRating[0]['star5'] + 1, 'user_id': list});
          odoo.update('res.users', userId, {'ratings': li.toList()});
      break;
    default:
  }
}

Future<bool> checkIfrated(Odoo odoo, userId, centreId) async {
  List user = await odoo.query(from: 'res.users', select: [], where: [
    ['id', '=', userId]
  ]);
  List rating = await odoo.query(from: 'salon.rating', select: [], where: [
    ['spa_id', '=', centreId]
  ]);

  if (user[0]['ratings'].contains(rating[0]['id'])) {
    print(true);
    return true;
  } else {
    print(false);
    return false;
  }
}
