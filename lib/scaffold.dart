// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:roynaldi_flutter/nav/jadwal.dart';
import 'package:roynaldi_flutter/nav/absen.dart';
import 'package:roynaldi_flutter/nav/listKul.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    AbsenTab(),
    JadwalTab(),
    ListTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Color.fromARGB(255, 114, 109, 109),
        fixedColor: Color.fromARGB(255, 0, 0, 0),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Absensi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule_outlined),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_2_outlined),
            label: 'List Perkuliahan',
          ),
        ],
      ),
    );
  }
}

class AbsenTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Absen()
    );
  }
}

class JadwalTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Jadwal(),
    );
  }
}

class ListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Login(),
    );
  }
}
