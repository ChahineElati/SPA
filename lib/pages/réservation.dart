import 'package:flutter/material.dart';
import 'package:spa/models/chair.dart';
import 'package:spa/services/book.dart';
import 'package:spa/services/chaise_services.dart';

class Reservation extends StatefulWidget {
  const Reservation({Key? key, required this.odoo, required this.centre})
      : super(key: key);
  final odoo;
  final centre;
  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  late String dropDownValue ="";
  @override
  Widget build(BuildContext context) {
    getchairsBySpaId(widget.centre.id, widget.odoo);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réservation'),
        centerTitle: true,
        backgroundColor: const Color(0xff008a00),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const Center(
              child: Image(
            image: AssetImage(
              'assets/book.jpg',
            ),
            width: 200,
            height: 200,
          )),
          const Text('Choisir la place:'),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
                future: getchairsBySpaId(widget.centre.id, widget.odoo),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null) {
                    return DropdownButton(
                      borderRadius: BorderRadius.circular(10.0),
                      value: dropDownValue,
                      items: _dropDownItem(snapshot.data),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue = newValue!;
                          print(dropDownValue);
                        });
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
          ElevatedButton(
              onPressed: () {
                book(widget.odoo);
              },
              child: const Text('réserver'))
        ],
      ),
    );
  }
}

List<DropdownMenuItem<String>> _dropDownItem(list) {
  List<DropdownMenuItem<String>> data = list
      .map<DropdownMenuItem<String>>((Chair value) => DropdownMenuItem<String>(
            child: Text(value.name),
            value: value.name,
          ))
      .toList();
  data.insert(
      0, const DropdownMenuItem(value: "", child: Text("Choisir la place"), enabled: false,));
  return data;
}
