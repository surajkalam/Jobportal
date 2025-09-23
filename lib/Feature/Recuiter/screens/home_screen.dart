import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // You can watch providers here for real data
    // final jobStats = ref.watch(jobStatisticsProvider);
    // final recentActivities = ref.watch(recentActivitiesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Recruiter Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistics Cards
            Row(
              children: [
                _buildStatCard('Total Jobs', '12', Iconsax.briefcase, Colors.blue),
                SizedBox(width: 10),
                _buildStatCard('Applications', '45', Iconsax.document, Colors.green),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                _buildStatCard('Active Jobs', '8', Iconsax.activity, Colors.orange),
                SizedBox(width: 10),
                _buildStatCard('Shortlisted', '15', Iconsax.profile_2user, Colors.purple),
              ],
            ),
            
            SizedBox(height: 20),
            Text('Recent Activities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(icon, color: color, size: 30),
              SizedBox(height: 5),
              Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(title, style: TextStyle(fontSize: 12)),
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
        title: Text(title),
        subtitle: Text(time),
      ),
    );
  }
}