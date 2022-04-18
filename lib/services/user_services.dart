import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/api/google_sign_in_api.dart';
import 'package:spa/models/user.dart';
import 'package:spa/pages/espace_personnel.dart';
import 'package:spa/parent.dart';
import 'package:spa/services/centre_services.dart';

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
  // GoogleSignInApi.logOut();
  // return 0;
  // final user = await GoogleSignInApi.login();
  // if (user == null) return 0;
  // final auth = await user.authentication;
  // final token = auth.accessToken!;

  final email = 'chahinosaiyan@gmail.com';
  final pwd = '1272000ch';
  final smtpServer = gmail(email, pwd);
  final message = Message()
    ..from = Address(email, 'chahine')
    ..recipients = [rcpEmail]
    ..subject = 'Confirmation Code'
    ..text =
        'Type the code below to confirm you are the owner of the account\n- $code';
  try {
    await send(message, smtpServer);
    print('email sent');
  } on Exception catch (e) {
    print(e);
  }
  return 0;
}
