import 'package:flutter/material.dart';

List<Widget> serviceTemplate(services) {
  List<Widget> list = [];
  for (var service in services) {
    Widget listeTile = Column(
      children: [
        ListTile(
          title: Text(
            service.nom,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          tileColor: Colors.greenAccent[100],
          trailing: Text(
            '${service.prix.toString()} Dt',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        const SizedBox(height: 5.0,)
      ],
    );
    list.add(listeTile);
  }
  return list;
}
