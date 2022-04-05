// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:spa/pages/accueil.dart';
import 'package:spa/pages/liste_centres.dart';
import 'package:spa/pages/login.dart';
import 'package:spa/pages/profil.dart';
import 'package:spa/pages/reservations.dart';
import 'package:spa/strings.dart';

class SPA extends StatefulWidget {
  final user;

  const SPA({Key? key, required this.user}) : super(key: key);

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
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.only(left: 7.0),
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          children: <Widget>[
            Accueil(
              user: widget.user,
            ),
            ListeCentres(),
            widget.user == null ? Login() : Reservations(),
            widget.user == null ? Login() : Profil(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(27, 94, 32, 1),
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.spa),
            label: 'Centres',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_calendar_rounded),
            label: 'Mes Réservations',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
            backgroundColor: Colors.green,
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(pagesNames[_selectedIndex]),
        centerTitle: true,
        backgroundColor: Color(0xff008a00),
        automaticallyImplyLeading: false,
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
