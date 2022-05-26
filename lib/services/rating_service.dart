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
    return true;
  } else {
    return false;
  }
}

Future<int> getLastRatingId(Odoo odoo) async {
  var id = await odoo.query(
    from: 'salon.rating',
    select: ['id'],
    orderBy: 'id DESC',
    limit: 1,
  );
  return id[0]['id'];
}

Future<String> averageRating(Odoo odoo, centreId) async {
  var rating = await odoo.query(from: 'salon.rating', select: [], where: [
    ['spa_id', '=', centreId]
  ]).then((value) => value[0]);
  int totalStar1 = rating['star1'];
  int totalStar2 = rating['star2'];
  int totalStar3 = rating['star3'];
  int totalStar4 = rating['star4'];
  int totalStar5 = rating['star5'];
  int totalRating =
      totalStar1 + totalStar2 + totalStar3 + totalStar4 + totalStar5;
  int ratingSum = (totalStar1 * 1) +
      (totalStar2 * 2) +
      (totalStar3 * 3) +
      (totalStar4 * 4) +
      (totalStar5 * 5);
  double averageRating = ratingSum / totalRating;
  if (!averageRating.isNaN) {
    await odoo
        .update('salon.centre', centreId, {'avg_rating': averageRating});
        return averageRating.toStringAsFixed(2);
  }
  else {
    return "0.00";
  }
  
}
