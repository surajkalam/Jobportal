import 'package:flutter/material.dart';
import 'package:jobapp/Feature/JobSeeker/profilescreen.dart';
import 'package:jobapp/Feature/JobSeeker/searchscreen.dart';
import 'package:jobapp/Feature/Recuiter/jobdetails.dart';

class RecuiterNavbar extends StatefulWidget {
  const RecuiterNavbar({super.key});

  @override
  State<RecuiterNavbar> createState() => _MainNavbarState();
}

class _MainNavbarState extends State<RecuiterNavbar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    JobdetailScreen(),
    searchscreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // show selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
