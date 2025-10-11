import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../provider/provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  
  int getTotalJobs(WidgetRef ref) {
    final totalJobsAsync = ref.watch(totalJobsCountProvider);
    return totalJobsAsync.maybeWhen(
      data: (value) => value,
      orElse: () => 0,
    );
  }
 
  int getActiveJobsCount(WidgetRef ref) {
    final activeJobsAsync = ref.watch(activeJobsCountProvider);
    return activeJobsAsync.maybeWhen(
      data: (jobsList) => jobsList,
      orElse: () => 0, 
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalJobs = getTotalJobs(ref);
    final activeJobs = getActiveJobsCount(ref);
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    log("Active Jobs: $activeJobs");
    log("Total Jobs: $totalJobs");

    return Scaffold(
      appBar: AppBar(
        title: Text('Recruiter Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistics Cards
            Row(
              children: [
                _buildStatCard('Total Jobs', totalJobs, Iconsax.briefcase, Colors.blue,height,width),
                const SizedBox(width: 10),
                _buildStatCard('Applications', activeJobs, Iconsax.document, Colors.green,height,width),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildStatCard('Active Jobs', activeJobs, Iconsax.activity, Colors.orange,height,width),
                const SizedBox(width: 10),
                _buildStatCard('Shortlisted', totalJobs, Iconsax.profile_2user, Colors.purple,height,width),
              ],
            ),
            
            const SizedBox(height: 20),
            const Text('Recent Activities', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildActivityItem('New application received', '2 hours ago'),
                  _buildActivityItem('Job posted successfully', '5 hours ago'),
                  _buildActivityItem('Candidate shortlisted', '1 day ago'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, int value, IconData icon, Color color,double height,double width) {
    return Expanded(
      child: Card(
        child: Padding(
          padding:  EdgeInsets.all(width*0.014),
          child: Column(
            children: [
              Icon(icon, color: color, size: 30),
               SizedBox(height:height*0.005),
              Text('$value', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(title, style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String time) {
    return Card(
      child: ListTile(
        leading: Icon(Iconsax.notification),
        title: Text(title,
        style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500)
        ),
        subtitle: Text(time,style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400)),
      ),
    );
  }
  void _showSnackBar({
    required BuildContext context,
    required String text,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.green,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, 
        style: TextStyle(
          color: textColor,
          fontSize: 10,
        fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: behavior,
        margin: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: textColor),
        ),
      ),
    );
  }
}