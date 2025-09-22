import 'package:flutter/material.dart';
import 'package:jobapp/Feature/JobSeeker/homescreen.dart';
import 'package:jobapp/Feature/JobSeeker/profilescreen.dart';
import 'package:jobapp/Feature/JobSeeker/searchscreen.dart';

class JobseekerNavbar extends StatefulWidget {
  const JobseekerNavbar({super.key});

  @override
  State<JobseekerNavbar> createState() => _MainNavbarState();
}

class _MainNavbarState extends State<JobseekerNavbar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
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
