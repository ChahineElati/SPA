import 'package:flutter/material.dart';
import 'package:spa/strings.dart';

void main() => runApp(MaterialApp(
      title: appName,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: SPA(),
    ));

class SPA extends StatelessWidget {
  const SPA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text(interfaceAccueil),
      centerTitle: true,
    ));
  }
}
