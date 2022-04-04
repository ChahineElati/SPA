import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/pages/espace_personnel.dart';
import 'package:spa/parent.dart';

Odoo odoo =
    Odoo(Connection(url: Url(Protocol.http, "192.168.1.6", 8069), db: 'SPA'));

Future<Object> login(BuildContext context, TextEditingController email,
    TextEditingController pwd) async {
  try {
    UserLoggedIn userLogin =
        await odoo.connect(Credential(email.text, pwd.text));
    int id = userLogin.uid;
    var userType = (await odoo.read('res.users', id));
    if (userType!['user_salon_active']) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EspacePersonnelSPA(user: userLogin, odoo: odoo)));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SPA(user: userLogin)));
    }
    return true;
  } on Exception catch (e) {
    print(e.toString());
    return showDialog(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
              content: Text('invalid'),
            ));
  }
}

void creerCompteClient(BuildContext context, TextEditingController nomComplet,
    TextEditingController email, TextEditingController mdp) async {
  await odoo.connect(Credential("chahinosaiyan@gmail.com", "1272000Ch*"));
  await odoo.insert('res.users', {
    "name": nomComplet.text,
    "login": email.text,
    "password": mdp.text,
    "user_salon_active": false,
  });
  odoo.disconnect();
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const SPA(user: null)));
}

void creerComptePersonnel(
  BuildContext context,
  TextEditingController nomCentre,
  TextEditingController email,
  TextEditingController mdp,
) async {
  await odoo.connect(Credential("chahinosaiyan@gmail.com", "1272000Ch*"));
  await odoo.insert('res.users', {
    "name": nomCentre.text,
    "login": email.text,
    "password": mdp.text,
    "user_salon_active": true,
  });
  odoo.disconnect();
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const SPA(user: null)));
}
