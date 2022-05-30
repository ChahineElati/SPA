// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:spa/pages/creer_compte_client.dart';
import 'package:spa/services/email_validator.dart';
import 'package:spa/services/user_services.dart';
import 'package:spa/pages/creer_compte_personnel.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final pwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20.0),
      child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Title(
                  color: Colors.black,
                  child: const Text(
                    "S'identifier",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  )),
              const Icon(Icons.account_circle_rounded,
                  size: 150, color: Color(0xff008a00)),
              SizedBox(
                width: 300,
                child: TextFormField(
                  validator: (value) => validateEmail(value),
                  controller: email,
                  decoration: const InputDecoration(
                      hintText: 'Email',
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
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  validator: (value) {
                    if (value == "" || value == null) {
                      return "Champ vide";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: 'Mot de Passe',
                      label: Text('Mot de Passe'),
                      counterText: '',
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20)),
                  maxLength: 40,
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login(context, email, pwd);
                          pwd.clear();
                        }
                      },
                      child: const Text(
                        'S\'identifier',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        fixedSize: const Size(130, 40),
                        primary: const Color.fromARGB(255, 55, 206, 55),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreerCompte()));
                      },
                      child: const Text(
                        'Devenir un client',
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(
                              0xff008a00,
                            ),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const Text(
                    'ou',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CreerComptePersonnel()));
                    },
                    child: const Text(
                      'Devenir un personnel SPA',
                      softWrap: true,
                      style: TextStyle(
                            fontSize: 15,
                            color: Color(
                              0xff008a00,
                            ),
                            fontWeight: FontWeight.w600),
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
