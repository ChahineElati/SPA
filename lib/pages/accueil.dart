// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/models/centre.dart';
import 'package:spa/pages/informations_centre.dart';
import 'package:spa/services/centre_services.dart';
import 'package:spa/strings.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                padding: EdgeInsets.only(top: 30),
                child: SizedBox(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150),
                          ),
                          width: 220,
                          height: 220,
                          child: Image(
                              image: AssetImage('assets/spa logo 2.png'),
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
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 60,
            width: 1000,
            decoration: BoxDecoration(
                // border: Border.symmetric(
                //   horizontal: BorderSide(color: Colors.green, width: 2),
                // ),
                image: DecorationImage(
              image: AssetImage(
                'assets/text box violet.jpg',
              ),
              fit: BoxFit.cover,
            )),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
              child: Text('LES MEUILLEURS CENTRES SPA',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Merienda One',
                    letterSpacing: 1.5,
                    color: Colors.white,
                  )),
            ),
          ),
          FutureBuilder<List<Centre>>(
            future: getTop3Centres(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data != null) {
                return ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      int randomIndex = Random().nextInt(spaImages.length);
                      return Card(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 500,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.spa,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        snapshot.data[index].nom,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                height: 43,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  color: Colors.purple[700],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.purple[700],
                                        ),
                                        Text(
                                          'localisation : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17),
                                        ),
                                        Text(
                                          '${snapshot.data[index].addresse}',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 23),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Note : ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17),
                                          ),
                                          Text(
                                            '${snapshot.data[index].avgRating.toStringAsFixed(2)}',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow.shade700,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        InformationsCentre(
                                                          centre: snapshot
                                                              .data[index],
                                                          odoo: widget.odoo,
                                                          user: widget.user,
                                                          image: randomIndex,
                                                        )));
                                          },
                                          child: const Text(
                                            'Services',
                                            style: TextStyle(fontSize: 15.0),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              fixedSize: const Size(90, 40),
                                              primary: Colors.purple),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ));
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
