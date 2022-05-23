// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/models/user.dart';
import 'package:spa/pages/espace_personnel.dart';
import 'package:spa/parent.dart';
import 'package:spa/services/centre_services.dart';

Odoo odoo =
    Odoo(Connection(url: Url(Protocol.http, "localhost", 8069), db: 'SPA'));

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
              builder: (context) =>
                  EspacePersonnelSPA(user: userLogin, odoo: odoo)));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SPA(user: userLogin, odoo: odoo)));
    }
    return true;
  } on Exception catch (e) {
    print(e.toString());
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Login Invalide'),
              content: const Text('Email ou mot de passe incorrecte.'),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Réssayer',
                      style: TextStyle(fontSize: 17.0),
                    ))
              ],
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
      context,
      MaterialPageRoute(
          builder: (context) => SPA(
                user: null,
                odoo: odoo,
              )));
}

void creerComptePersonnel(
  BuildContext context,
  TextEditingController nomCentre,
  TextEditingController email,
  TextEditingController mdp,
  TextEditingController addresse,
) async {
  await odoo.connect(Credential("chahinosaiyan@gmail.com", "1272000Ch*"));
  await ajouterCentre(odoo, nomCentre.text, addresse.text);
  int idCentre = await getIdDernierCentre(odoo);
  await odoo.insert('res.users', {
    "name": nomCentre.text,
    "login": email.text,
    "password": mdp.text,
    "personnel_centre": idCentre,
    "user_salon_active": true,
  });
  odoo.disconnect();
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SPA(
                user: null,
                odoo: odoo,
              )));
}

Future<User> getUser(id) async {
  var user = await odoo.read('res.users', id);
  return User(user!['name'], user['login'], user['password']);
}

Future<int> sendCode(code, rcpEmail) async {
  const email = 'chahinosaiyan@gmail.com';
  const pwd = '1272000ch';
  final smtpServer = gmail(email, pwd);
  final message = Message()
    ..from = const Address(email, 'chahine')
    ..recipients = [rcpEmail]
    ..subject = 'Confirmation Code'
    ..html = '''
              <h1>Confirmation code</h1>
              <p>Enter this confirmation code in field:</p>
              <span><font style="font-family: "Times New Roman", Times, serif;">$code<font></span>
''';
  try {
    await send(message, smtpServer);
    print('email sent');
  } on Exception catch (e) {
    print(e);
  }
  return 0;
}

void updateUser(id, nom, mdp) async {
  await odoo.update('res.users', id, {'name': nom, 'password': mdp});
}
