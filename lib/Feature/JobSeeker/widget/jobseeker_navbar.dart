import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:iconsax/iconsax.dart';
import '../jobseekers_screens/jobseekers_screens.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

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
      backgroundColor: Color(0xFF1F2937),
      body: currentScreen,
      extendBody: true,
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          bottom: 10,
          left: 16,
          right: 16,
        ),
        decoration: BoxDecoration(
          color: Color(0xFF374151),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: 70, // Reduced height
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8), // Added padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  context: context,
                  ref: ref,
                  index: 0,
                  currentIndex: currentIndex,
                  activeIcon: Iconsax.home_15,
                  inactiveIcon: Iconsax.home_1,
                ),
                _buildNavItem(
                  context: context,
                  ref: ref,
                  index: 1,
                  currentIndex: currentIndex,
                  activeIcon: Iconsax.briefcase5,
                  inactiveIcon: Iconsax.briefcase,
                ),
                _buildNavItem(
                  context: context,
                  ref: ref,
                  index: 2,
                  currentIndex: currentIndex,
                  activeIcon: Iconsax.message5,
                  inactiveIcon: Iconsax.message,
                ),
                _buildNavItem(
                  context: context,
                  ref: ref,
                  index: 3,
                  currentIndex: currentIndex,
                  activeIcon: Iconsax.profile_circle5,
                  inactiveIcon: Iconsax.profile_circle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required WidgetRef ref,
    required int index,
    required int currentIndex,
    required IconData activeIcon,
    required IconData inactiveIcon,
  }) {
    final isActive = currentIndex == index;
    
    return GestureDetector(
      onTap: () {
        ref.read(currentIndexProvider.notifier).state = index;
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isActive ? Color(0xFF3B82F6) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Icon(
            isActive ? activeIcon : inactiveIcon,
            size: 24,
            color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}