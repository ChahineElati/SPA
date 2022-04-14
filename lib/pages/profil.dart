// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/models/user.dart';
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

  @override
  Widget build(BuildContext context) {
    Future<User> user = getUser(widget.user!.uid);
    return Padding(
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
            children: [
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
                onEditingComplete: (() => setState(() {
                      editerNom = false;
                    })),
                initialValue: snapshot.data.nom,
                enabled: editerNom,
                focusNode: focusNom,
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Text('Modifier votre Email'),
                  TextButton.icon(
                      onPressed: () {
                        setState(() {
                          editerEmail = true;
                        });
                        Future.delayed(Duration(milliseconds: 100), () {
                          focusEmail.requestFocus();
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
                onEditingComplete: (() => setState(() {
                      editerEmail = false;
                    })),
                initialValue: snapshot.data.email,
                enabled: editerEmail,
                focusNode: focusEmail,
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Text('Changer votre mot de passe'),
                  TextButton.icon(
                      onPressed: () {
                        setState(() {
                          editerMdp = true;
                        });
                        Future.delayed(Duration(milliseconds: 100), () {
                          focusMdp.requestFocus();
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
            ],
          ));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    )
        ],
      ),
    );
  }
}

