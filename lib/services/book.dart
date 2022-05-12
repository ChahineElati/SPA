void book(odoo) async {
  final moonLanding = DateTime.parse('1969-07-20 20:18:04Z');
  odoo.insert('salon.booking', {'name':'chahine', 'phone':'11222333', 'email':'chahino@gmail.com', 'chair_id':28, 'services': [3, 7], 'time': '2022-01-01 10:10:00'});
}