// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:spa/services/service_services.dart';

class InformationsCentre extends StatefulWidget {
  const InformationsCentre({Key? key, required this.centre, required this.odoo}) : super(key: key);
  final centre;
  final odoo;
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
                  const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
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
                              return Text(snapshot.data[index]['name']);
                          });
                        } else {
                          return const Center(
                            child: CircularProgressIndicator());
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
