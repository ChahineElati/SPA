// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/models/service.dart';
import 'package:spa/services/chaise_services.dart';
import 'package:spa/services/service_services.dart';
import 'package:spa/services/user_services.dart';
import 'package:spa/strings.dart';

class EspacePersonnelSPA extends StatefulWidget {
  const EspacePersonnelSPA(
      {Key? key,
      required this.user,
      required this.odoo,
      required this.centreId})
      : super(key: key);

  final UserLoggedIn user;
  final Odoo? odoo;
  final int centreId;

  @override
  State<EspacePersonnelSPA> createState() => _EspacePersonnelSPAState();
}

class _EspacePersonnelSPAState extends State<EspacePersonnelSPA> {
  late final UserLoggedIn currentUser;

  List services = [];

  String selectedService = servicesDisponibles[0];

  @override
  void initState() {
    currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getServices(widget.centreId, widget.odoo!).then((value) {
        setState(() {
          services = value;
        });
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Espace SPA'),
        centerTitle: true,
        backgroundColor: Color(0xff008a00),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Column(
                  children: const [
                    Icon(
                      Icons.settings_applications,
                      size: 110,
                      color: Color(0xff008a00),
                    ),
                    Text(
                      "Gestion Espace SPA",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 15),
                    Divider(
                      height: 2,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vos services',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(services[index].nom),
                              ),
                              Divider(),
                            ],
                          );
                        }),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        ajouterChaise(currentUser.uid, odoo);
                      },
                      child: Text('ajouter chaise')),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: Text('Ajouter un service'),
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                
                                    children: [
                                      Text('Service : '),
                                      Expanded(
                                        child: DropdownButtonFormField<String>(
                                            value: selectedService,
                                            items: servicesDisponibles
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) =>
                                                        DropdownMenuItem<String>(
                                                          child: Text(value),
                                                          value: value,
                                                        ))
                                                .toList(),
                                            onChanged: (String? newValue){
                                              setState(() {
                                                selectedService = newValue!;
                                              });
                                            }),
                                      ),
                                    ],
                                  ));
                            });
                        // addService(currentUser.uid, odoo);
                      },
                      child: Text('ajouter service')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
