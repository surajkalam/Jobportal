import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class ApplicationsScreen extends ConsumerStatefulWidget {
  const ApplicationsScreen({super.key});

  @override
  ConsumerState<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends ConsumerState<ApplicationsScreen> {
  @override
  Widget build(BuildContext context) {
    // Watch application data from providers
    // final appStats = ref.watch(applicationStatsProvider);
    // final recentApps = ref.watch(recentApplicationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Applications'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Application Statistics
            Row(
              children: [
                _buildAppStatCard('Total', '45', Colors.blue),
                _buildAppStatCard('Pending', '12', Colors.orange),
                _buildAppStatCard('Shortlisted', '8', Colors.green),
                _buildAppStatCard('Rejected', '25', Colors.red),
              ],
            ),
            SizedBox(height: 20),
            Text('Recent Applications', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildApplicationItem('John Doe', 'Airline Cabin Crew', 'Pending'),
                  _buildApplicationItem('Sarah Smith', 'Hotel Manager', 'Shortlisted'),
                  _buildApplicationItem('Mike Johnson', 'Front Desk Executive', 'Rejected'),
                  _buildApplicationItem('Emma Wilson', 'Airline Cabin Crew', 'Pending'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppStatCard(String title, String value, Color color) {
    return Expanded(
      child: Card(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.1),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
              Text(title, style: TextStyle(fontSize: 10, color: color)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApplicationItem(String name, String job, String status) {
    Color statusColor = status == 'Pending' ? Colors.orange : 
                        status == 'Shortlisted' ? Colors.green : Colors.red;
    
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(name[0])),
        title: Text(name),
        subtitle: Text(job),
        trailing: Chip(
          label: Text(status, style: TextStyle(color: Colors.white, fontSize: 10)),
          backgroundColor: statusColor,
        ),
      ),
    );
  }
}