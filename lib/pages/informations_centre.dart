// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:spa/main.dart';
import 'package:spa/pages/r%C3%A9servation.dart';
import 'package:spa/services/rating_service.dart';
import 'package:spa/services/service_services.dart';
import 'package:spa/strings.dart';

class InformationsCentre extends StatefulWidget {
  const InformationsCentre(
      {Key? key,
      required this.centre,
      required this.odoo,
      required this.user,
      this.image})
      : super(key: key);
  final image;
  final centre;
  final odoo;
  final user;
  @override
  State<InformationsCentre> createState() => _InformationsCentreState();
}

class _InformationsCentreState extends State<InformationsCentre> {
  var rated = false;

  Future<bool> getRated() async {
    return await session.get('isRated');
  }

  @override
  void initState() {
    getRated().then((value) {
      if (value) {
        setState(() {
          rated = value;
        });
      }
    });
    averageRating(widget.odoo, widget.centre.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.centre.nom),
        centerTitle: true,
        backgroundColor: Colors.purple[700]
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Image(
                image: AssetImage(spa_images[widget.image]),
                fit: BoxFit.cover,
              ),
              height: 150,
              width: 1000,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.centre.nom,
                    style:
                        const TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                  ),
                  FutureBuilder<String>(
                      future: averageRating(widget.odoo, widget.centre.id),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Row(
                            children: [
                              Text(
                                'Avis moyenne ${snapshot.data} ',
                                style: const TextStyle(fontSize: 20),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow.shade700,
                                size: 23,
                              ),
                            ],
                          );
                        } else {
                          return const Text('');
                        }
                      }),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Evaluer ',
                        style: TextStyle(fontSize: 15),
                      ),
                      RatingBar.builder(
                        ignoreGestures: rated,
                        itemSize: 15,
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) async {
                          if (widget.user != null && widget.user.uid != 2) {
                            if (!rated) {
                              setState(() {
                                rated = true;
                              });
                              updateRating(widget.odoo, widget.centre.id, rating,
                                  widget.user.uid);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  widget.user != null && widget.user.uid != 2
                      ? rated == false
                          ? const Text('')
                          : const Text('vous avez évalué ce centre')
                      : const Text('Veillez connecter pour évaluer'),
                  Text(
                    widget.centre.addresse,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  FutureBuilder<List>(
                    future: getServices(widget.centre.id, widget.odoo),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data != null) {
                        return ListView.builder(
                          shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${snapshot.data[index].nom}',
                                      style: const TextStyle(fontSize: 20.0),
                                    ),
                                    Text(
                                      'prix: ${snapshot.data[index].prix} Dt',
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          color: Colors.purple[700],
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const Divider(height: 20.0),
                                  ],
                                ),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    if (widget.user != null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Reservation(
                                                    odoo: widget.odoo,
                                                    centre: widget.centre,
                                                    service: snapshot.data[index],
                                                    user: widget.user,
                                                  )));
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                content: const Text(
                                                    'Veillez vous connecter pour réserver.'),
                                                actionsAlignment:
                                                    MainAxisAlignment.center,
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: const Text(
                                                        'Fermer',
                                                        style: TextStyle(
                                                            fontSize: 17.0),
                                                      ))
                                                ],
                                              ));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      fixedSize: const Size(90, 40),
                                      primary: Colors.purple),
                                  child: const Text('Réserver'),
                                ),
                              );
                            });
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
