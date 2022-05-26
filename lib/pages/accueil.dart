// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';

class Accueil extends StatefulWidget {
  final UserLoggedIn? user;
  final Odoo? odoo;
  const Accueil({Key? key, required this.user, required this.odoo})
      : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Image(
                image: AssetImage('assets/spa.jpg'),
                fit: BoxFit.fitHeight,
                height: 490,
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 10),
                child: SizedBox(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0x0fffffff).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(150),
                          ),
                          width: 250,
                          height: 250,
                            child: Image(
                                image: AssetImage('assets/logo1.jpg'),
                                fit: BoxFit.contain),
                        
                            ),
                        Text(
                          'SPA BOOKING',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
