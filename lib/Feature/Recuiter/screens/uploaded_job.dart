import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class UploadJobsScreen extends ConsumerStatefulWidget {
  const UploadJobsScreen({super.key});

  @override
  ConsumerState<UploadJobsScreen> createState() => _UploadJobsScreenState();
}

class _UploadJobsScreenState extends ConsumerState<UploadJobsScreen> {
  @override
  Widget build(BuildContext context) {
    // Watch recent jobs from provider
    // final recentJobs = ref.watch(recentJobsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Jobs'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Job Upload Guidelines', 
                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    _buildGuidelineItem('Fill all required fields marked with *'),
                    _buildGuidelineItem('Upload clear company logo/image'),
                    _buildGuidelineItem('Provide accurate CTC information'),
                    _buildGuidelineItem('Mention clear job requirements'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Recent Uploaded Jobs', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildJobItem('Airline Cabin Crew', 'Airline', 'Active'),
                  _buildJobItem('Hotel Manager', 'Hospitality', 'Active'),
                  _buildJobItem('Front Desk Executive', 'Hospitality', 'Closed'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelineItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 12),
          SizedBox(width: 8),
          Text(text,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildJobItem(String title, String category, String status) {
    return Card(
      child: ListTile(
        leading: Icon(Iconsax.briefcase),
        title: Text(title),
        subtitle: Text(category),
        trailing: Chip(
          label: Text(status, style: TextStyle(color: Colors.white)),
          backgroundColor: status == 'Active' ? Colors.green : Colors.grey,
        ),
      ),
    );
  }
}