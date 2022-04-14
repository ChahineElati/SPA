import 'package:flutter/material.dart';
import 'package:spa/services/user_services.dart';

import '../services/email_validator.dart';

class CreerComptePersonnel extends StatefulWidget {
  const CreerComptePersonnel({Key? key}) : super(key: key);

  @override
  State<CreerComptePersonnel> createState() => _CreerComptePersonnelState();
}

class _CreerComptePersonnelState extends State<CreerComptePersonnel> {
  final _comptePersonnelFormKey = GlobalKey<FormState>();
  final nomCentre = TextEditingController();
  final email = TextEditingController();
  final mdp = TextEditingController();
  final addresse = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Inscription'),
        centerTitle: true,
        backgroundColor: const Color(0xff008a00),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: _comptePersonnelFormKey,
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
                    const Icon(Icons.account_circle_rounded,
                        size: 150, color: Color(0xff008a00)),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: nomCentre,
                        validator: (value) {
                          if (value == "" || value == null) {
                            return "Champ vide";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: 'Nom de Centre',
                            label: Text('Nom de Centre'),
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
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: addresse,
                        validator: (value) {
                          if (value == "" || value == null) {
                            return "Champ vide";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: 'Addresse',
                            label: Text('Addresse'),
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
                              if (_comptePersonnelFormKey.currentState!
                                  .validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Compte Créé avec succés')),
                                );
                                creerComptePersonnel(
                                    context, nomCentre, email, mdp, addresse);
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
                                primary: const Color(0xFF34c759)),
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
                                primary: const Color(0xFF34c759)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
