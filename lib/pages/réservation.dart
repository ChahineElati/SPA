import 'package:flutter/material.dart';
import 'package:spa/models/chair.dart';
import 'package:spa/models/service.dart';
import 'package:spa/services/book.dart';
import 'package:spa/services/chaise_services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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

  late List<Service> services;

  @override
  void initState() {
    services = [widget.service];
    super.initState();
  }

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
                    children: const [
                      Icon(Icons.spa, color: Colors.green),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
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
                  TextButton(onPressed: (){}, child: Row(children: const [ Icon(Icons.add), Text('Ajouter un autre service')],)),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(Icons.chair_alt, color: Colors.green),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
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
                    children: const [
                      Icon(Icons.calendar_month, color: Colors.green),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
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
                    children: const [
                      Icon(Icons.access_time_outlined, color: Colors.green),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
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
                      'Total : ${widget.service.prix}',
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
                            time);
                        if (!isReserved) {
                          book(widget.odoo, widget.user, dropDownValue,
                              widget.service.id, '$annee-$mois-$jour $time:00');
                        } else {
                          print('déjà réservée');
                        }
                      },
                      child: const Text('Réserver'),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          fixedSize: const Size(90, 40),
                          primary: const Color(0xFF34c759)),
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
