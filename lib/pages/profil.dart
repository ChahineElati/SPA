// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/models/user.dart';
import 'package:spa/services/random_string.dart';
import 'package:spa/services/user_services.dart';

class Profil extends StatefulWidget {
  final Odoo? odoo;
  final UserLoggedIn? user;
  const Profil({Key? key, required this.user, required this.odoo})
      : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  bool editerNom = false;
  bool editerEmail = false;
  bool editerMdp = false;
  FocusNode focusNom = FocusNode();
  FocusNode focusEmail = FocusNode();
  FocusNode focusMdp = FocusNode();
  TextEditingController code = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final nom = TextEditingController();
  final mdp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<User> user = getUser(widget.user!.uid);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Modifier Profil",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20.0,
            ),
            Divider(),
            SizedBox(
              height: 20.0,
            ),
            FutureBuilder<User>(
              future: user,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  return Form(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nom et Prénom : ${snapshot.data.nom}'),
                      Row(
                        children: [
                          Text('Modifier votre nom et prénom'),
                          TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  editerNom = true;
                                });
                                Future.delayed(Duration(milliseconds: 100), () {
                                  focusNom.requestFocus();
                                });
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 15,
                              ),
                              label: Text('')),
                        ],
                      ),
                      TextFormField(
                        controller: nom,
                        onEditingComplete: (() => setState(() {
                              editerNom = false;
                            })),
                        enabled: editerNom,
                        focusNode: focusNom,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Text('Changer votre mot de passe'),
                          TextButton.icon(
                              onPressed: () {
                                String code = generateRandomString(6);
                                sendCode(code, widget.user!.username);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) => Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AlertDialog(
                                              title: const Text(
                                                  'Confirmation Code'),
                                              content: Column(
                                                children: [
                                                  const Text(
                                                      'un code de confirmation a été envoyé à votre compte gmail'),
                                                  Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                            enableSuggestions:
                                                                false,
                                                            autocorrect: false,
                                                            validator: (value) {
                                                              if (value !=
                                                                  code) {
                                                                return 'incorrecte';
                                                              } else {
                                                                return null;
                                                              }
                                                            },
                                                            controller:
                                                                this.code,
                                                          ),
                                                          TextButton(
                                                              onPressed: () {
                                                                if (_formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  setState(() {
                                                                    editerMdp =
                                                                        true;
                                                                  });
                                                                  Future.delayed(
                                                                      Duration(
                                                                          milliseconds:
                                                                              100),
                                                                      () {
                                                                    focusMdp
                                                                        .requestFocus();
                                                                  });
                                                                }
                                                              },
                                                              child: Text(
                                                                'Confirmer',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17.0,
                                                                    letterSpacing:
                                                                        1.0),
                                                              ))
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 0,
                                            ),
                                          ],
                                        ));
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 15,
                              ),
                              label: Text('')),
                        ],
                      ),
                      TextFormField(
                        controller: mdp,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        onEditingComplete: (() => setState(() {
                              editerMdp = false;
                            })),
                        decoration: InputDecoration(hintText: '••••••••'),
                        enabled: editerMdp,
                        focusNode: focusMdp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                updateUser(widget.user!.uid, nom.text, mdp.text);
                              },
                              child: const Text(
                                'Valider',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  fixedSize: const Size(100, 40),
                                  primary: const Color(0xFF34c759)),
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                        ],
                      ),
                    ],
                  ));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
