import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:iconsax/iconsax.dart'; // Add this import for Iconsax
import '../jobseekers_screens/jobseekers_screens.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

// Provider for getting current screen based on index
final currentScreenProvider = Provider<Widget>((ref) {
  final index = ref.watch(currentIndexProvider);
  final screens = [
    JobSeekerDashboard(),
    searchscreen(),
    MessageScreen(),
    JobseekerProfileScreen(),
  ];
  return screens[index];
});

class JobseekerNavbar extends ConsumerWidget {
  const JobseekerNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final currentScreen = ref.watch(currentScreenProvider);

    return Scaffold(
      backgroundColor: Color(0xFF1F2937), // Dark gray background
      body: currentScreen,
      extendBody: true, // This makes the body extend behind the navbar
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          bottom: 10, // Smaller bottom margin
          left: 16, // Left margin
          right: 16, // Right margin
        ),
        decoration: BoxDecoration(
          color: Color(0xFF374151), // Darker gray for navbar
          borderRadius: BorderRadius.circular(30), // More rounded
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 5), // Shadow for floating effect
            ),
          ],
        ),
        child: Container(
          height: 80, // Increased height to prevent overflow
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30), // More rounded
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                ref.read(currentIndexProvider.notifier).state = index;
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor:
                  Colors.transparent, // Make background transparent
              elevation: 0, // Remove default elevation
              selectedItemColor: Colors.transparent,
              unselectedItemColor: Colors.transparent,
              showSelectedLabels: false, // Hide labels
              showUnselectedLabels: false, // Hide labels
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center, // Center the icon
                    decoration: BoxDecoration(
                      color: currentIndex == 0
                          ? Color(0xFF3B82F6)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20), // More rounded
                    ),
                    child: Icon(
                      currentIndex == 0 ? Iconsax.home_15 : Iconsax.home_1,
                      size: 24,
                      color: currentIndex == 0
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                  label: '', // Empty label
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center, // Center the icon
                    decoration: BoxDecoration(
                      color: currentIndex == 1
                          ? Color(0xFF3B82F6)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20), // More rounded
                    ),
                    child: Icon(
                      currentIndex == 1
                          ? Iconsax.briefcase5
                          : Iconsax.briefcase,
                      size: 24,
                      color: currentIndex == 1
                          ? Colors.white
                          // ignore: deprecated_member_use
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                  label: '', // Empty label
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center, // Center the icon
                    decoration: BoxDecoration(
                      color: currentIndex == 2
                          ? Color(0xFF3B82F6)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20), // More rounded
                    ),
                    child: Icon(
                      currentIndex == 2 ? Iconsax.message5 : Iconsax.message,
                      size: 24,
                      color: currentIndex == 2
                          ? Colors.white
                          // ignore: deprecated_member_use
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                  label: '', // Empty label
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center, // Center the icon
                    decoration: BoxDecoration(
                      color: currentIndex == 3
                          ? Color(0xFF3B82F6)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20), // More rounded
                    ),
                    child: Icon(
                      currentIndex == 3
                          ? Iconsax.profile_circle5
                          : Iconsax.profile_circle,
                      size: 24,
                      color: currentIndex == 3
                          ? Colors.white
                          // ignore: deprecated_member_use
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                  label: '', // Empty label
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
