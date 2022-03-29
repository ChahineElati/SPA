// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/parent.dart';

class CreerCompte extends StatelessWidget {
  const CreerCompte({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nomComplet = TextEditingController();
    final email = TextEditingController();
    final mdp = TextEditingController();
    Odoo odoo =
        Odoo(Connection(url: Url(Protocol.http, "localhost", 8069), db: 'SPA'));
        
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
        centerTitle: true,
        backgroundColor: Color(0xff008a00),
        automaticallyImplyLeading: false,
      ),
      body: Card(
        child: Form(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Title(
                    color: Colors.black,
                    child: const Text(
                      "S'inscrire",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    )),
                Icon(Icons.account_circle_rounded,
                    size: 150, color: Color(0xff008a00)),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: nomComplet,
                    decoration: InputDecoration(
                        label: Text('Nom et Prénom'),
                        counterText: '',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20)),
                    maxLength: 40,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                        label: Text('Email'),
                        counterText: '',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20)),
                    maxLength: 40,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: mdp,
                    decoration: InputDecoration(
                        label: Text('Mot de Passe'),
                        counterText: '',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20)),
                    maxLength: 40,
                  ),
                ),
                // SizedBox(
                //   width: 300,
                //   child: TextFormField(
                //     controller: email,
                //     decoration: InputDecoration(
                //         label: Text('Confirmer Mot de Passe'),
                //         counterText: '',
                //         labelStyle:
                //             TextStyle(color: Colors.black, fontSize: 20)),
                //     maxLength: 40,
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          await odoo.connect(Credential("chahinosaiyan@gmail.com", "1272000Ch*"));
                          await odoo.insert('res.users', {"name":nomComplet.text, "login":email.text, "password":mdp.text, });
                          odoo.disconnect();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SPA(user: null)));
                        },
                        child: Text(
                          'Inscrire',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(110, 40),
                            primary: Color(0xFF34c759)),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Annuler',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(110, 40),
                            primary: Color(0xFF34c759)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
