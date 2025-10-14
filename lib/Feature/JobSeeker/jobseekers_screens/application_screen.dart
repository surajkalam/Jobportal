// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:jobapp/core/util.dart/appcolors.dart';

// // ignore: camel_case_types
// class JobApplicationscreen extends StatefulWidget {
//   const JobApplicationscreen({super.key});

//   @override
//   State<JobApplicationscreen> createState() => _JobApplicationscreenState();
// }

// class _JobApplicationscreenState extends State<JobApplicationscreen> {
//   TextEditingController searchcontroller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final textTheme = Theme.of(context).textTheme;
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppColors.faintbackblue, AppColors.white],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             stops: [0.04, 0.3],
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.only(top:height*0.02),
//           child: Column(
//             children: [
//               SizedBox(height: 50),
//               Padding(
//                 padding: EdgeInsets.only(
//                   left: width * 0.02,
//                   right: width * 0.025,
//                 ),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: 'search a job ..',
//                     hintStyle: textTheme.bodySmall?.copyWith(
//                       color: colorScheme.secondary,
//                     ),
//                     prefixIcon: Icon(Iconsax.search_normal),
//                     labelText: 'search',
//                     labelStyle: textTheme.bodySmall?.copyWith(
//                       color: colorScheme.secondary,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     filled: true,
//                     fillColor: colorScheme.surface,
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: colorScheme.secondary),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(
//                         color: colorScheme.onSecondary,
//                         width: 2.0,
//                       ),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(30),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     contentPadding: EdgeInsets.zero,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Padding(
//                 padding: EdgeInsets.only(
//                   left: width * 0.02,
//                   right: width * 0.025,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [Text('My status')],
//                 ),
//               ),
//               detailsContainer(height, width),
//               SizedBox(height: height*0.01,),
//               Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     // ignore: deprecated_member_use
//                     color: AppColors.faintbackblue.withOpacity(0.1),
//                     border: Border.all(color: Colors.black),
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(20),
//                       topLeft: Radius.circular(20),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       left: width * 0.02,
//                       right: width * 0.02,
//                       top: height * 0.01,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('My applications'),
//                         SizedBox(height: height * 0.002),
//                         Expanded(
//                           child: ListView(
//                             children: [
//                               applicationContainer(height, width),
//                               SizedBox(height: height * 0.02),
//                               applicationContainer(height, width),
//                               SizedBox(height: height * 0.02),
//                               applicationContainer(height, width),
//                               SizedBox(height: height * 0.02),
//                               applicationContainer(height, width),
//                               SizedBox(height: height * 0.02),
//                               applicationContainer(height, width),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget detailsContainer(double height, double width) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 10, horizontal: width * 0.024),
//       child: Container(
//         height:
//             height * 0.12, // Slightly increased height to accommodate content
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black38,
//               offset: Offset(0, 4),
//               blurRadius: 5,
//               spreadRadius: 0,
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: 8,
//             vertical: 12,
//           ), // Reduced vertical padding
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(color: Colors.white),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         '17 Jobs',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(height: 4), // Reduced spacing
//                       Text(
//                         'Applied',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 10,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 width: 1,
//                 height: 30,
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(color: Colors.white),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         '5 Jobs',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(height: 4), // Reduced spacing
//                       Text(
//                         'Shortlisted',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 10,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 width: 1,
//                 height: 30,
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(color: Colors.white),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         '4 Jobs',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(height: 4), // Reduced spacing
//                       Text(
//                         'Rejected',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 10,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget applicationContainer(double height, double width) {
//     return Container(
//       height: height * 0.2,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black38,
//             offset: Offset(0, 4),
//             blurRadius: 5,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Text(
//                   'Software Engineer',
//                   style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 // ignore: deprecated_member_use
//                 Text(
//                   'Congnizant | Banglore',
//                   style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                     // ignore: deprecated_member_use
//                     color: Colors.black.withOpacity(0.5),
//                   ),
//                 ),
//                 Spacer(),
//                 Container(
//                   height: height * 0.02,
//                   width: width * 0.04,
//                   decoration: BoxDecoration(
//                     color: AppColors.faintbackblue,
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: height * 0.01),
//             Row(
//               children: [
//                 // ignore: deprecated_member_use
//                 Icon(Icons.location_pin, size: 15, color: Colors.black),
//                 Text(
//                   'Banglore',
//                   style: TextStyle(
//                     fontSize: 11,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black.withOpacity(0.5),
//                   ),
//                 ),
//                 SizedBox(width: width * 0.01),
//                 Icon(Icons.wallet, size: 15, color: Colors.black),
//                 Text(
//                   '5 -7 LPA',
//                   style: TextStyle(
//                     fontSize: 11,
//                     fontWeight: FontWeight.w400,
//                     // ignore: deprecated_member_use
//                     color: Colors.black.withOpacity(0.5),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: height * 0.01),
//             Row(
//               children: [
//                 Icon(Icons.calendar_today, size: 15, color: Colors.black),
//                 SizedBox(width: width * 0.02),
//                 Text('0 -2 years', style: TextStyle(fontSize: 12)),
//               ],
//             ),
//             SizedBox(height: height * 0.01),
//             Padding(
//               padding: EdgeInsets.only(left: width * 0.05),
//               child: Row(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       // ignore: deprecated_member_use
//                       color: Colors.greenAccent.withOpacity(0.2),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: width * 0.02,
//                         vertical: height * 0.002,
//                       ),
//                       child: Center(
//                         child: Row(
//                           children: [
//                             Icon(Icons.alarm, size: 12, color: Colors.green),
//                             SizedBox(width: width * 0.01),
//                             Text(
//                               'posted 1 day ago',
//                               style: TextStyle(
//                                 fontSize: 08,
//                                 fontWeight: FontWeight.w400,
//                                 // ignore: deprecated_member_use
//                                 color: Colors.green,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: width * 0.04),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       // ignore: deprecated_member_use
//                       color: AppColors.white,
//                       border: BoxBorder.all(color: AppColors.black),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: width * 0.02,
//                         vertical: height * 0.002,
//                       ),
//                       child: Center(
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.alarm,
//                               size: 12,
//                               color: AppColors.darkblue,
//                             ),
//                             SizedBox(width: width * 0.01),
//                             Text(
//                               'posted 1 day ago',
//                               style: TextStyle(
//                                 fontSize: 08,
//                                 fontWeight: FontWeight.w400,
//                                 // ignore: deprecated_member_use
//                                 color: AppColors.darkblue,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// applied_jobs_screen.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobapp/Feature/JobSeeker/provider/application_provider.dart';
import 'package:jobapp/core/util.dart/appcolors.dart';

class AppliedJobsScreen extends ConsumerWidget {
  const AppliedJobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Applications'),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Statistics Section
          _buildStatisticsSection(ref),
          SizedBox(height: 16),
          
          // Applications List
          Expanded(
            child: _buildApplicationsList(ref),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection(WidgetRef ref) {
    final stats = ref.watch(applicationStatsProvider);
    
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Total', stats.total, Colors.blue),
          _buildStatItem('Pending', stats.pending, Colors.orange),
          _buildStatItem('Shortlisted', stats.shortlisted, Colors.green),
          _buildStatItem('Rejected', stats.rejected, Colors.red),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, int count, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildApplicationsList(WidgetRef ref) {
    final applicationsAsync = ref.watch(appliedJobsProvider);
    
    return applicationsAsync.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 48),
            SizedBox(height: 16),
            Text(
              'Error loading applications',
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => ref.refresh(appliedJobsProvider),
              child: Text('Retry'),
            ),
          ],
        ),
      ),
      data: (applications) {
        if (applications.isEmpty) {
          return _buildEmptyState();
        }
        
        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: applications.length,
          itemBuilder: (context, index) {
            return _buildApplicationCard(applications[index]);
          },
        );
      },
    );
  }

  Widget _buildApplicationCard(Map<String, dynamic> application) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    application['job_title'] ?? 'Unknown Job',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _buildStatusBadge(application['status'] ?? 'pending'),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Company: ${application['recruiter_email']?.split('@').first ?? 'Unknown'}',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.grey,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: AppColors.grey),
                SizedBox(width: 4),
                Text(
                  _formatDate(application['applied_at']),
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;
    String statusText;

    switch (status) {
      case 'shortlisted':
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        statusText = 'Shortlisted';
        break;
      case 'rejected':
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
        statusText = 'Rejected';
        break;
      default:
        backgroundColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        statusText = 'Pending';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColor.withOpacity(0.3)),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          fontSize: 12,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.work_outline, size: 64, color: AppColors.grey),
          SizedBox(height: 16),
          Text(
            'No Applications Yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Apply to jobs to see them here',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return 'Unknown date';
    
    try {
      if (timestamp is Timestamp) {
        final date = timestamp.toDate();
        return '${date.day}/${date.month}/${date.year}';
      }
      return 'Unknown date';
    } catch (e) {
      return 'Unknown date';
    }
  }
}
