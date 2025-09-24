import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../jobseekers_screens/jobseeker_screen.dart';
class JobseekerNavbar extends StatefulWidget {
  const JobseekerNavbar({super.key});

  @override
  State<JobseekerNavbar> createState() => _JobseekerNavbarState();
}

class _JobseekerNavbarState extends State<JobseekerNavbar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    JobSeekerHomeScreen(),
    JobseekerInfo(),
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