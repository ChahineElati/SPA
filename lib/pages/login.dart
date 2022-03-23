// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/pages/accueil.dart';
import 'package:spa/parent.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final pwd = TextEditingController();
    Odoo odoo = Odoo(Connection(url: Url(Protocol.http, "192.168.0.103", 8069), db: 'SPA'));
    UserLoggedIn user;
    return Form(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_circle_rounded,
                size: 150, color: Color(0xff008a00)),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                    label: Text('Email'),
                    counterText: '',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20)),
                maxLength: 40,
              ),
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: pwd,
                decoration: InputDecoration(
                    label: Text('Mot de Passe'),
                    counterText: '',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20)),
                maxLength: 40,
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      user = await odoo.connect(Credential(email.text, pwd.text));
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SPA(user: user)));
                    } on Exception catch (e) {
                      print(e.toString());
                    }
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(90, 40), primary: Color(0xFF34c759)),
                )),
          ],
        ),
      ),
    );
  }
}