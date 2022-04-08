// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/services/chaise_services.dart';
import 'package:spa/services/user_services.dart';

class EspacePersonnelSPA extends StatefulWidget {
  const EspacePersonnelSPA({Key? key,required this.user, required this.odoo}) : super(key: key);

  final UserLoggedIn user;
  final Odoo? odoo;

  @override
  State<EspacePersonnelSPA> createState() => _EspacePersonnelSPAState();
}

class _EspacePersonnelSPAState extends State<EspacePersonnelSPA> {
  
  late final UserLoggedIn currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = widget.user;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Espace SPA'),
        centerTitle: true,
        backgroundColor: Color(0xff008a00),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Text("Espace personnel SPA"),
          ElevatedButton(onPressed: () {ajouterChaise(currentUser.uid, odoo);}
          , child: Text('ajouter chaise'))
        ],
      ),
    );
  }
}
