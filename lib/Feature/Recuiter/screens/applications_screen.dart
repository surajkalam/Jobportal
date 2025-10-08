import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobapp/core/util.dart/appcolors.dart';
class ApplicationsScreen extends ConsumerStatefulWidget {
  const ApplicationsScreen({super.key});
  @override
  ConsumerState<ApplicationsScreen> createState() => _ApplicationsScreenState();
}
class _ApplicationsScreenState extends ConsumerState<ApplicationsScreen> {
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applications'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
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
          SizedBox(height:height*0.02),
          Text('Recent Applications', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          SizedBox(height: height*0.01),
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

  Widget _buildAppStatCard(String title, String value,Color color ) {
    return Expanded(
      child: Card(
        shadowColor: Colors.black,
        color: Colors.white,
        child: Padding(
          padding:  EdgeInsets.all(8),
          child: Column(
            children: [
              Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color)),
              Text(title, style: TextStyle(fontSize: 08, color: color)),
            ],
          ),

        ),
      ),
    );
  }

  Widget _buildApplicationItem(String name, String job, String status) {
    Color statusColor = status == 'Pending'
         ? Colors.orange
        :status == 'Shortlisted'
        ? Colors.green
        : Colors.red;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 5),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(child: Text(name[0])),
          title: Text(name,
            style: TextStyle(fontSize: 13, color:AppColors.black ,fontWeight: FontWeight.w600,),
          ),
          subtitle: Text(job,
           style: TextStyle(fontSize: 10, color:AppColors.black.withOpacity(0.4) ,fontWeight: FontWeight.w400,),
          ),
          trailing: Chip(
            label: Text(status, style:TextStyle(color: Colors.white, fontSize: 10)),
            backgroundColor: statusColor,
          ),
        ),
      ),
    );
  }
}