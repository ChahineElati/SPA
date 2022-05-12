// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:spa/pages/r%C3%A9servation.dart';
import 'package:spa/services/service_services.dart';
import 'package:spa/services/user_services.dart';

class InformationsCentre extends StatefulWidget {
  const InformationsCentre(
      {Key? key, required this.centre, required this.odoo, required this.user})
      : super(key: key);
  final centre;
  final odoo;
  final user;
  @override
  State<InformationsCentre> createState() => _InformationsCentreState();
}

class _InformationsCentreState extends State<InformationsCentre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.centre.nom),
        centerTitle: true,
        backgroundColor: const Color(0xff008a00),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.centre.nom,
              style:
                  const TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.centre.addresse,
              style: const TextStyle(color: Colors.grey),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back')),
            Expanded(
              child: FutureBuilder<List>(
                future: getServices(widget.centre.id, widget.odoo),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
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
                                  style: const TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.green,
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
                                          builder: (context) =>
                                              Reservation(odoo: widget.odoo,)));
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
                                                    'Continuer',
                                                    style: TextStyle(
                                                        fontSize: 17.0),
                                                  ))
                                            ],
                                          ));
                                }
                              },
                              child: const Text('Réserver'),
                            ),
                          );
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
