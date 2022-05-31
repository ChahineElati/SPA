// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:flutter/material.dart';
import 'package:spa/models/chair.dart';
import 'package:spa/models/service.dart';
import 'package:spa/services/book.dart';
import 'package:spa/services/chaise_services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:spa/services/service_services.dart';
import 'package:spa/services/service_template.dart';

class Reservation extends StatefulWidget {
  const Reservation(
      {Key? key,
      required this.odoo,
      required this.centre,
      required this.service,
      required this.user})
      : super(key: key);
  final odoo;
  final centre;
  final service;
  final user;
  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  List<String> daytimes = [
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00'
  ];

  late String time = daytimes[0];
  late int dropDownValue = 0;
  String annee = "AAAA";
  String mois = "MM";
  String jour = "JJ";
  late double prixTotal;

  late List<Service> services;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    prixTotal = widget.service.prix;
    services = [widget.service];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getchairsBySpaId(widget.centre.id, widget.odoo);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Réservation'),
        centerTitle: true,
        backgroundColor: Colors.purple[700],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          const Center(
              child: Image(
            image: AssetImage(
              'assets/book.jpg',
            ),
            width: 200,
            height: 200,
          )),
          Form(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.spa, color: Colors.purple[700]),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const Text(
                        'Services : ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  ListView(
                    children: serviceTemplate(services),
                    shrinkWrap: true,
                  ),
                  TextButton(
                      onPressed: () async {
                        List<Service> list =
                            await getServices(widget.centre.id, widget.odoo)
                                .then((value) => value);
                        List<Widget> listTemplate = list
                            .map((Service service) => Card(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: TextButton(
                                          child: Text(
                                            service.nom,
                                            style: const TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black),
                                          ),
                                          onPressed: () {
                                            if (!checkIfExists(
                                                services, service)) {
                                              setState(() {
                                                services.add(service);
                                                prixTotal += service.prix;
                                                Navigator.of(context).pop();
                                              });
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      AlertDialog(
                                                        actionsAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                'Fermer',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18.0,
                                                                    color: Colors.white
                                                                            ),
                                                              ))
                                                        ],
                                                        content: const Center(
                                                          heightFactor: 2,
                                                          child: Text(
                                                            'Service déjà ajouté',
                                                            style: TextStyle(
                                                                color: Colors
                                                                        .white,
                                                                fontSize: 18.0),
                                                          ),
                                                        ),
                                                        backgroundColor: Colors
                                                            .redAccent[400],
                                                      ));
                                            }
                                          },
                                        ),
                                        trailing: Text('${service.prix} Dt'),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Ajouter un service'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Retourner',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.purple[700]),
                                        ))
                                  ],
                                  actionsAlignment: MainAxisAlignment.center,
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: listTemplate,
                                    ),
                                  ),
                                ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.purple[700]),
                          Text(
                            'Ajouter un autre service',
                            style: TextStyle(color: Colors.purple[700]),
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.chair_alt, color: Colors.purple[700]),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const Text(
                        'Choisir la place:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: FutureBuilder<List<dynamic>>(
                        future: getchairsBySpaId(widget.centre.id, widget.odoo),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.data != null) {
                            return DropdownButtonFormField<int>(
                              value: dropDownValue,
                              items: _dropDownItem(snapshot.data),
                              onChanged: (int? newValue) {
                                setState(() {
                                  dropDownValue = newValue!;
                                });
                              },
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month, color: Colors.purple[700]),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const Text(
                        'Choisir le jour:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextButton(
                      onPressed: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          onConfirm: (date) {
                            setState(() {
                              annee = date.year.toString();
                              mois = date.month > 9
                                  ? date.month.toString()
                                  : '0${date.month.toString()}';
                              jour = date.day > 9
                                  ? date.day.toString()
                                  : '0${date.day.toString()}';
                            });
                          },
                          currentTime: DateTime.now(),
                        );
                      },
                      child: const Center(
                          child:
                              Icon(Icons.calendar_month, color: Colors.grey))),
                  const Divider(),
                  Center(
                      child: Text(
                    '$jour/$mois/$annee',
                    style: const TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.w600),
                  )),
                  const Divider(),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time_outlined,
                          color: Colors.purple[700]),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const Text(
                        'Choisir l\'heure:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  DropdownButtonFormField(
                    value: time,
                    items: daytimes
                        .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                                  child: Text(value),
                                  value: value,
                                ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        time = newValue!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 210.0),
                    child: Text(
                      'Total : ${prixTotal.toStringAsFixed(2)} Dt',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        bool isReserved = await verifierTempsReservation(
                          widget.odoo,
                          dropDownValue,
                          '$annee-$mois-$jour',
                          time,
                        );
                        if (dropDownValue != 0 &&
                            jour != "JJ" &&
                            annee != "AAAA" &&
                            mois != "MM") {
                          if (!isReserved) {
                            List<int> servicesIds =
                                services.map((value) => value.id).toList();
                            book(
                                widget.odoo,
                                widget.user,
                                dropDownValue,
                                servicesIds,
                                '$annee-$mois-$jour $time:00',
                                prixTotal);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.greenAccent[400],
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.fromLTRB(15, 0, 15, 50),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Réservation succés',
                                    style: TextStyle(letterSpacing: 1),
                                  ),
                                ],
                              ),
                              duration: const Duration(seconds: 2),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.redAccent[400],
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.fromLTRB(15, 0, 15, 50),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Déjà réservé',
                                    style: TextStyle(letterSpacing: 1),
                                  ),
                                ],
                              ),
                              duration: const Duration(seconds: 2),
                            ));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.redAccent[400],
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.fromLTRB(15, 0, 15, 50),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Veillez indiquer tout les champs',
                                  style: TextStyle(letterSpacing: 1),
                                ),
                              ],
                            ),
                            duration: const Duration(seconds: 2),
                          ));
                        }
                      },
                      child: const Text('Réserver'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        fixedSize: const Size(90, 40),
                        primary: Colors.purple,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<DropdownMenuItem<int>> _dropDownItem(list) {
  List<DropdownMenuItem<int>> data = list
      .map<DropdownMenuItem<int>>((Chair value) => DropdownMenuItem<int>(
            child: Text(value.name),
            value: value.id,
          ))
      .toList();
  data.insert(
      0,
      const DropdownMenuItem(
        value: 0,
        child: Text("Choisir la place"),
        enabled: false,
      ));
  return data;
}

bool checkIfExists(services, service) {
  bool exists = false;
  for (var currService in services) {
    if (currService.id == service.id) {
      exists = true;
      break;
    }
  }
  return exists;
}
