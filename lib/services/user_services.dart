// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/models/user.dart';
import 'package:spa/pages/espace_personnel.dart';
import 'package:spa/parent.dart';
import 'package:spa/services/centre_services.dart';
import 'package:spa/services/rating_service.dart';
import 'package:spa/strings.dart';
import 'package:http/http.dart' as http;

Odoo odoo = Odoo(Connection(url: Url(Protocol.http, host, 8069), db: 'SPA'));

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
              builder: (context) => EspacePersonnelSPA(
                  user: userLogin,
                  odoo: odoo,
                  centreId: userType['personnel_centre'][0])));
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
                    child: Text(
                      'Réssayer',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.purple[700],
                      ),
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
  await odoo.insert('salon.rating', {});
  int id = await getLastRatingId(odoo);
  await ajouterCentre(odoo, nomCentre.text, addresse.text, id);
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

Future sendCode({required code, required rcpEmail}) async {
  const serviceId = "service_s3bw9pd";
  const templateId = "template_15yj8th";
  const userId = "Euuf-W_EcpJEwLsUo";

  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  final response = await http.post(
    url,
    headers: {
      'origin': 'http://localhost',
      'Content-Type': 'application/json'
    },
    body: json.encode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
        'user_email': rcpEmail,
        'code': code,
      }
    })
  );
  print(response.body);
}

void updateUser(id, nom, mdp) async {
  await odoo.update('res.users', id, {'name': nom, 'password': mdp});
}
