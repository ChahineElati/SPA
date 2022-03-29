// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/pages/creer_compte.dart';
import 'package:spa/parent.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final pwd = TextEditingController();
    Odoo odoo = Odoo(
        Connection(url: Url(Protocol.http, "192.168.1.48", 8069), db: 'SPA'));
    UserLoggedIn user;

    return Card(
      child: Form(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          user = await odoo.connect(Credential(email.text, pwd.text));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SPA(user: user)));
                        } on Exception catch (e) {
                          print(e.toString());
                        }
                        // create();
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(90, 40), primary: Color(0xFF34c759)),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreerCompte()));
                      },
                      child: Text(
                        'Create Account',
                        softWrap: true,
                        style: TextStyle(fontSize: 20.0),
                      ),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(180, 40), primary: Color(0xFF34c759)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
