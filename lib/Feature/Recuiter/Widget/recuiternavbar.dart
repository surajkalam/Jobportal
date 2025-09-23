import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../screens/screens.dart';

class RecruiterNavbar extends StatefulWidget {
  const RecruiterNavbar({super.key});

  @override
  State<RecruiterNavbar> createState() => _RecruiterNavbarState();
}

class _RecruiterNavbarState extends State<RecruiterNavbar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    UploadJobsScreen(),
    ApplicationsScreen(),
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.add_square),
            label: "Upload Jobs",
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.document_text),
            label: "Applications",
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.user),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}