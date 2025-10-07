// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:iconsax/iconsax.dart';

// import '../provider/provider.dart';

// class HomeScreen extends ConsumerStatefulWidget {
//   const HomeScreen({super.key});
//   @override
//   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends ConsumerState<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // You can watch providers here for real data
//     // final jobStats = ref.watch(jobStatisticsProvider);
//     // final recentActivities = ref.watch(recentActivitiesProvider);

//     int getTotalJobs(WidgetRef ref) {
//   final totalJobsAsync = ref.watch(totalJobsCountProvider);
//   return totalJobsAsync.maybeWhen(
//     data: (value) => value,
//     orElse: () => 0, // Return 0 while loading or on error
//   );
// } 
 
// int getActiveJobsCount(WidgetRef ref) {
//   final activeJobsAsync = ref.watch(activeJobsCountProvider);
//   return activeJobsAsync.maybeWhen(
//     data: (jobsList) => jobsList,
//     orElse: () => 0, 
//   );
// }
// final int count =getActiveJobsCount(ref);
// log("Active Jobs:$count");

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Recruiter Dashboard'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Statistics Cards
//             Row(
//               children: [
//                 _buildStatCard('Total Jobs', getTotalJobs(ref), Iconsax.briefcase, Colors.blue),
//                 SizedBox(width: 10),
//                 _buildStatCard('Applications', getActiveJobsCount(ref), Iconsax.document, Colors.green),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 _buildStatCard('Active Jobs', getActiveJobsCount(ref), Iconsax.activity, Colors.orange),
//                 SizedBox(width: 10),
//                 _buildStatCard('Shortlisted', getTotalJobs(ref), Iconsax.profile_2user, Colors.purple),
//               ],
//             ),
            
//             SizedBox(height: 20),
//             Text('Recent Activities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Expanded(
//               child: ListView(
//                 children: [
//                   _buildActivityItem('New application received', '2 hours ago'),
//                   _buildActivityItem('Job posted successfully', '5 hours ago'),
//                   _buildActivityItem('Candidate shortlisted', '1 day ago'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStatCard(String title, int value, IconData icon, Color color) {
//     return Expanded(
//       child: Card(
//         child: Padding(
//           padding: EdgeInsets.all(12),
//           child: Column(
//             children: [
//               Icon(icon, color: color, size: 30),
//               SizedBox(height: 5),
//               Text('$value', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               Text(title, style: TextStyle(fontSize: 12)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildActivityItem(String title, String time) {
//     return Card(
//       child: ListTile(
//         leading: Icon(Iconsax.notification),
//         title: Text(title),
//         subtitle: Text(time),
//       ),
//     );
//   }
// }
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
    
    log("Active Jobs: $activeJobs");
    log("Total Jobs: $totalJobs");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recruiter Dashboard'),
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
                _buildStatCard('Total Jobs', totalJobs, Iconsax.briefcase, Colors.blue),
                const SizedBox(width: 10),
                _buildStatCard('Applications', activeJobs, Iconsax.document, Colors.green),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildStatCard('Active Jobs', activeJobs, Iconsax.activity, Colors.orange),
                const SizedBox(width: 10),
                _buildStatCard('Shortlisted', totalJobs, Iconsax.profile_2user, Colors.purple),
              ],
            ),
            
            const SizedBox(height: 20),
            const Text('Recent Activities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

  Widget _buildStatCard(String title, int value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 5),
              Text('$value', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(title, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String time) {
    return Card(
      child: ListTile(
        leading: const Icon(Iconsax.notification),
        title: Text(title),
        subtitle: Text(time),
      ),
    );
  }
}