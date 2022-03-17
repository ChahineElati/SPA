import 'package:flutter/material.dart';
import 'package:spa/accueil.dart';
import 'package:spa/login.dart';
import 'package:spa/strings.dart';
import 'package:odoo/odoo.dart';

void main() => runApp(MaterialApp(
      title: appName,
      theme: ThemeData(primarySwatch: Colors.green),
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
      ),
      // body: ElevatedButton(
      //   onPressed: () {odoo();},
      //   child: Text('Get username'),),

      body: Login(),
    );
  }

  void odoo() async {
    final odoo = Odoo(
        Connection(url: Url(Protocol.http, "192.168.1.48", 8069), db: 'SPA'));
    UserLoggedIn user =
        await odoo.connect(Credential("chahinosaiyan@gmail.com", "1272000Ch*"));
    print(user.username);
  }
}
