import 'package:flutter/material.dart';
  
class Accueil extends StatelessWidget {
  const Accueil({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(child: Text('Bienvenue'))
        ]),
    );
  }
}