// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:odoo/odoo.dart';
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
  List places = [];
  final prix = TextEditingController();
  final place = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String selectedService = servicesDisponibles[0];
  List clients = [];

  @override
  void initState() {
    currentUser = widget.user;
    widget.odoo!.query(from: 'salon.booking', select: [
      'name',
      'email',
      'spa_id'
    ], where: [
      ['spa_id', '=', widget.centreId]
    ]).then((value) {
      setState(() {
        clients = value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getServices(widget.centreId, widget.odoo!).then((value) {
      setState(() {
        services = value;
      });
    });
    getchairsBySpaId(widget.centreId, widget.odoo!).then((value) {
      setState(() {
        places = value;
      });
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Espace SPA'),
        centerTitle: true,
        backgroundColor: Colors.purple[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.settings_applications,
                      size: 110,
                      color: Colors.purple[700],
                    ),
                    Text(
                      widget.user.name,
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
                  Row(
                    children: [
                      Icon(Icons.spa, color: Colors.purple[700]),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Vos services',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(color: Colors.purple))),
                    height: 200,
                    child: services.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: services.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(services[index].nom)),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder:
                                                  (BuildContext context) =>
                                                      AlertDialog(
                                                        title: Text(
                                                            'Modifier Service'),
                                                        actionsAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                if (_formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  widget.odoo!.update(
                                                                      'salon.service',
                                                                      services[index].id,
                                                                      {
                                                                        'price':
                                                                            double.parse(prix.text)
                                                                      });
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }
                                                              },
                                                              child: Text(
                                                                'Confirmer',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .purple[
                                                                        700],
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ))
                                                        ],
                                                        content: Form(
                                                          key: _formKey,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                'Prix(Dt) : ',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                      "") {
                                                                    return 'champ vide';
                                                                  } else if (RegExp(
                                                                              r"\.")
                                                                          .allMatches(
                                                                              value.toString())
                                                                          .length >
                                                                      1) {
                                                                    return 'veillez saisir une valeur numérique';
                                                                  } else {
                                                                    return null;
                                                                  }
                                                                },
                                                                controller:
                                                                    prix,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                inputFormatters: <
                                                                    TextInputFormatter>[
                                                                  FilteringTextInputFormatter
                                                                      .allow(RegExp(
                                                                          r'[0-9.]'))
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ));
                                        },
                                        icon: Icon(Icons.edit,
                                            color: Colors.purple[700]),
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            await odoo.delete('salon.service',
                                                services[index].id);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              backgroundColor:
                                                  Colors.redAccent[400],
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: const EdgeInsets.fromLTRB(
                                                  15, 0, 15, 50),
                                              content: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Text(
                                                    'Service Supprimé',
                                                    style: TextStyle(
                                                        letterSpacing: 1),
                                                  ),
                                                ],
                                              ),
                                              duration:
                                                  const Duration(seconds: 2),
                                            ));
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ))
                                    ],
                                  ),
                                  Divider(),
                                ],
                              );
                            })
                        : Center(
                            child: Text(
                            'Aucun service ajouté',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          )),
                  ),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            addService(
                                                currentUser.uid,
                                                odoo,
                                                selectedService,
                                                double.parse(prix.text));
                                            Navigator.of(context).pop();
                                            prix.clear();
                                            setState(() {
                                              selectedService =
                                                  servicesDisponibles[0];
                                            });
                                          }
                                        },
                                        child: Text(
                                          "Confirmer",
                                          style: TextStyle(
                                              color: Colors.purple[700],
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ))
                                  ],
                                  title: Text('Ajouter un service'),
                                  content: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Service : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        DropdownButtonFormField<String>(
                                            validator: (value) {
                                              if (servicesNames(services)
                                                  .contains(value.toString())) {
                                                return "Service déjà ajouté";
                                              } else {
                                                return null;
                                              }
                                            },
                                            isExpanded: true,
                                            value: selectedService,
                                            items: servicesDisponibles
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          child: Text(
                                                            value,
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          value: value,
                                                        ))
                                                .toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedService = newValue!;
                                              });
                                            }),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Prix(Dt) : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        TextFormField(
                                          validator: (value) {
                                            if (value == "") {
                                              return 'champ vide';
                                            } else if (RegExp(r"\.")
                                                    .allMatches(
                                                        value.toString())
                                                    .length >
                                                1) {
                                              return 'veillez saisir une valeur numérique';
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: prix,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9.]'))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ));
                            });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.add, color: Colors.purple[700]),
                          Text(
                            'Ajouter un service',
                            style: TextStyle(
                                color: Colors.purple[700],
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Icon(Icons.chair_alt, color: Colors.purple[700]),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Vos Places (${places.length} places)',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(color: Colors.purple))),
                    height: 200,
                    child: places.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: places.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: Text(places[index].name)),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title:
                                                        Text('Modifier Place'),
                                                    actionsAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              widget.odoo!.update(
                                                                  'salon.chair',
                                                                  places[index]
                                                                      .id,
                                                                  {
                                                                    'name': place
                                                                        .text
                                                                  });

                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }
                                                            place.clear();
                                                          },
                                                          child: Text(
                                                            'Confirmer',
                                                            style: TextStyle(
                                                                color: Colors
                                                                        .purple[
                                                                    700],
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ))
                                                    ],
                                                    content: Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            'Nom Place : ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          TextFormField(
                                                              validator:
                                                                  (value) {
                                                                if (value ==
                                                                    "") {
                                                                  return 'champ vide';
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                              controller: place,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text),
                                                        ],
                                                      ),
                                                    ),
                                                  ));
                                        },
                                        icon: Icon(Icons.edit,
                                            color: Colors.purple[700]),
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            await odoo.delete('salon.chair',
                                                places[index].id);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              backgroundColor:
                                                  Colors.redAccent[400],
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: const EdgeInsets.fromLTRB(
                                                  15, 0, 15, 50),
                                              content: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Text(
                                                    'Place Supprimée',
                                                    style: TextStyle(
                                                        letterSpacing: 1),
                                                  ),
                                                ],
                                              ),
                                              duration:
                                                  const Duration(seconds: 2),
                                            ));
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ))
                                    ],
                                  ),
                                  Divider(),
                                ],
                              );
                            })
                        : Center(
                            child: Text(
                            'Aucune place ajouté',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text('Modifier Place'),
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                ajouterChaise(currentUser.uid,
                                                    odoo, place.text);

                                                Navigator.of(context).pop();
                                              }
                                              place.clear();
                                            },
                                            child: Text(
                                              'Confirmer',
                                              style: TextStyle(
                                                  color: Colors.purple[700],
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ))
                                      ],
                                      content: Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Nom Place : ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            TextFormField(
                                                validator: (value) {
                                                  if (value == "") {
                                                    return 'champ vide';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                controller: place,
                                                keyboardType:
                                                    TextInputType.text),
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.add, color: Colors.purple[700]),
                              Text(
                                'Ajouter une place',
                                style: TextStyle(
                                    color: Colors.purple[700],
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Icon(Icons.supervisor_account_rounded,
                          color: Colors.purple[700]),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Vos clients',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: clients.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(clients[index]['name']),
                        );
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<String> servicesNames(List services) {
  return services.map((e) => e.nom.toString()).toList();
}
