// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_circle_rounded,
              size: 150,
              color: Colors.green.shade900),
              SizedBox(
                width: 300,
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text('Email'),
                    counterText: '',
                    labelStyle: TextStyle(color: Colors.black,
                    fontSize: 20)
                    ),
                  maxLength: 20,
                ),
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text('Mot de Passe'),
                    counterText: '',
                    labelStyle: TextStyle(color: Colors.black,
                    fontSize: 20)
                    ),
                  maxLength: 20,
                ),
              ),
              ElevatedButton(onPressed: () {}, child: Text('Log In'))
            ],
          ),
        ),
      ),
    );
  }
}
