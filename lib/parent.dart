// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:odoo/odoo.dart';
import 'package:spa/main.dart';
import 'package:spa/pages/accueil.dart';
import 'package:spa/pages/liste_centres.dart';
import 'package:spa/pages/login.dart';
import 'package:spa/pages/profil.dart';
import 'package:spa/pages/liste_reservations.dart';
import 'package:spa/services/user_services.dart';

class SPA extends StatefulWidget {
  final UserLoggedIn? user;
  final Odoo? odoo;
  const SPA({Key? key, required this.user, required this.odoo})
      : super(key: key);

  @override
  State<SPA> createState() => _SPAState();
}

class _SPAState extends State<SPA> {
  int _selectedIndex = 0;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    odoo.connect(Credential('chahinosaiyan@gmail.com', '1272000Ch*'));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows) {
      setWindowSize();
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 0.0),
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _selectedIndex = index);
            },
            children: <Widget>[
              Accueil(
                user: widget.user,
                odoo: widget.odoo,
              ),
              widget.user == null
                  ? ListeCentres(odoo: odoo, user: widget.user)
                  : ListeCentres(odoo: widget.odoo, user: widget.user),
              widget.user == null || widget.user!.uid == 2
                  ? Login()
                  : Reservations(
                      user: widget.user,
                      odoo: widget.odoo,
                    ),
              widget.user == null || widget.user!.uid == 2
                  ? Login()
                  : Profil(user: widget.user, odoo: widget.odoo),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple[900],
        unselectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.spa),
            label: 'Centres',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_calendar_rounded),
            label: 'Mes Réservations',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
            backgroundColor: Colors.purple,
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }
}
