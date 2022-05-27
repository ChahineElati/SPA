// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/models/centre.dart';
import 'package:spa/pages/informations_centre.dart';
import 'package:spa/services/centre_card.dart';
import 'package:spa/services/centre_services.dart';

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
                          height: 240,
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
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 90,
            width: 1000,
            decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(color: Colors.green, width: 2),
                ),
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/title_background.jpg',
                  ),
                  fit: BoxFit.cover,
                )),
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, 30, 0, 0),
              child: Text('Les meuilleurs centres SPA',
                  style: TextStyle(
                    fontSize: 22,
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
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        snapshot.data[index].nom,
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                height: 75,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  color: Color(0xff008a00),
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
                                          color: Color(0xff008a00),
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
                                                            user:
                                                                widget.user)));
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
                                            fixedSize: const Size(85, 40),
                                            primary: Color.fromARGB(255, 55, 206, 55),
                                          ),
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
