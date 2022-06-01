// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:spa/services/centre_card.dart';
import 'package:spa/services/centre_services.dart';

import '../models/centre.dart';

class ListeCentres extends StatefulWidget {
  const ListeCentres({Key? key, required this.odoo, required this.user})
      : super(key: key);
  final odoo;
  final user;

  @override
  State<ListeCentres> createState() => _ListeCentresState();
}

class _ListeCentresState extends State<ListeCentres> {
  final search = TextEditingController();
  String searchResult = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: TextField(
              decoration: const InputDecoration(hintText: 'Recherche par cité'),
              controller: search,
            ),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    searchResult = search.text;
                  });
                },
                icon: const Icon(Icons.search)),
          ),
          searchResult == ""
              ? FutureBuilder<List<Centre>>(
                  future: getCentres(widget.odoo),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data != null) {
                      if (snapshot.data.length != 0) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return centreCard(context, snapshot.data[index],
                                  widget.odoo, widget.user);
                            });
                      } else {
                        return const Center(
                            child: Text(
                          'Aucune Réservation',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ));
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )
              : FutureBuilder<List<Centre>>(
                  future: getCentresFiltred(widget.odoo, searchResult),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data != null) {
                      if (snapshot.data.length != 0) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return centreCard(context, snapshot.data[index],
                                  widget.odoo, widget.user);
                            });
                      } else {
                        return const Center(
                            child: Text(
                          'Aucun Centre',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ));
                      }
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
