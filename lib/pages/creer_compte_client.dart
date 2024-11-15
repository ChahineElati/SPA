import 'package:flutter/material.dart';
import 'package:spa/services/email_validator.dart';
import 'package:spa/services/user_services.dart';

class CreerCompte extends StatefulWidget {
  const CreerCompte({Key? key}) : super(key: key);

  @override
  State<CreerCompte> createState() => _CreerCompteState();
}

class _CreerCompteState extends State<CreerCompte> {
  final _formKey = GlobalKey<FormState>();
  final nomComplet = TextEditingController();
  final email = TextEditingController();
  final mdp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Inscription'),
        centerTitle: true,
        backgroundColor: Colors.purple[700],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Title(
                    color: Colors.black,
                    child: const Text(
                      "S'inscrire",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    )),
                Icon(Icons.account_circle_rounded,
                    size: 150, color: Colors.purple[700]),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "Champ vide";
                      } else {
                        return null;
                      }
                    },
                    controller: nomComplet,
                    decoration: const InputDecoration(
                        hintText: 'Nom et Prénom',
                        label: Text('Nom et Prénom'),
                        counterText: '',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20)),
                    maxLength: 40,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: email,
                    validator: (value) => validateEmail(value),
                    decoration: const InputDecoration(
                        hintText: 'Email',
                        label: Text('Email'),
                        counterText: '',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20)),
                    maxLength: 40,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: mdp,
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
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20)),
                    maxLength: 40,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Champ vide';
                      } else if (value != mdp.text) {
                        return 'Non identique';
                      }
                      return null;
                    },
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        hintText: 'Confirmer Mot de Passe',
                        label: Text('Confirmer Mot de Passe'),
                        counterText: '',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20)),
                    maxLength: 40,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.greenAccent[400],
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.fromLTRB(15, 0, 15, 50),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Compte créé avec succés',
                                    style: TextStyle(letterSpacing: 1),
                                  ),
                                ],
                              ),
                              duration: const Duration(seconds: 2),
                            ));
                            creerCompteClient(context, nomComplet, email, mdp);
                          }
                        },
                        child: const Text(
                          'Inscrire',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          fixedSize: const Size(110, 40),
                          primary: Colors.purple,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Annuler',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          fixedSize: const Size(110, 40),
                          primary: Colors.purple,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
