import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jobapp/Feature/Recuiter/recuiter_model/jobupload_model.dart';
import 'package:jobapp/core/util.dart/appcolors.dart';
import '../provider/provider.dart';

final selectedTabProvider = StateProvider<String>((ref) => 'description');

class JobDetailsScreen extends ConsumerWidget {
  final JobModel job;

  const JobDetailsScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.01),
          child: Container(
            height: height * 0.008,
            width: width * 0.01,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70),
              border: Border.all(
                color: AppColors.darkGrey.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: Center(
              child: IconButton(
                icon: Icon(
                  Iconsax.arrow_left_2,
                  color: AppColors.black,
                  size: 22,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.01),
            child: Container(
              height: height * 0.12,
              width: width * 0.13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  color: AppColors.darkGrey.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.share_outlined,
                    color: AppColors.black,
                    size: 22,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
        ],
        title: Text(
          'Job Details',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Header Section
            _buildCompanyHeader(height, width, job),
            SizedBox(height: height * 0.008),
            Row(
              children: [
                jdcontainer('FullTime', width, height),
                jdcontainer('Remote', width, height),
                jdcontainer('3-4 YoE', width, height),
                jdcontainer('Finance', width, height),
              ],
            ),
            selectinfocontainer(context, width, height, ref),
            SizedBox(height: height * 0.01),

            // Job Details Section
            _buildJobDetails(job),
            SizedBox(height: 20),

            // Job Description
            _buildDescriptionSection(job),
            SizedBox(height: 20),

            // Requirements
            _buildRequirementsSection(job),
            SizedBox(height: 20),

            // Benefits
            _buildBenefitsSection(job),
            SizedBox(height: 30),

            // Apply Button
            _buildApplyButton(context, job),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyHeader(double height, double width, JobModel job) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppColors.grey),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  job.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.business, color: AppColors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.designation,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          job.companyName,
                          style: TextStyle(fontSize: 16, color: AppColors.grey),
                        ),
                        SizedBox(width: width * 0.01),
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: AppColors.grey,
                        ),
                        SizedBox(width: width * 0.005),
                        Text(
                          job.location,
                          style: TextStyle(color: AppColors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Icon(Iconsax.archive_add, size: 20, color: AppColors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget jdcontainer(String text, double width, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.01,
        horizontal: width * 0.014,
      ),
      child: Container(
        padding: EdgeInsets.all(width * 0.016),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: AppColors.lightblue.withOpacity(0.3),
          // ignore: deprecated_member_use
          border: Border.all(color: AppColors.grey.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildJobDetails(JobModel job) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildDetailRow('Salary', '${job.ctc}'),
          const SizedBox(height: 12),
          // _buildDetailRow('Employment Type', job.employmentType ?? 'Full-time'),
          _buildDetailRow('Employee time', 'Full-time'),
          const SizedBox(height: 12),
          // _buildDetailRow('Experience', job.experienceRequired ?? 'Not specified'),
          _buildDetailRow('Experience', 'Not specified'),
          const SizedBox(height: 12),
          _buildDetailRow('Posted', _calculateTimeAgo(job.createdAt)),
        ],
      ),
    );
  }

  Widget selectinfocontainer(
    BuildContext context,
    double width,
    double height,
    WidgetRef ref,
  ) {
    return Container(
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        border: Border.all(color: AppColors.grey.withOpacity(0.3)),
        // ignore: deprecated_member_use
        color: AppColors.verylightblue.withOpacity(0.3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          singleinfocontainer(width, height, 'description', ref),
          singleinfocontainer(width, height, 'Company', ref),
          singleinfocontainer(width, height, 'Reviews', ref),
        ],
      ),
    );
  }

  Widget singleinfocontainer(
    double width,
    double height,
    String text,
    WidgetRef ref,
  ) {
    final selectedTab = ref.watch(selectedTabProvider);
    final isSelected = selectedTab == text;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(selectedTabProvider.notifier).state = text;
        },
        child: Container(
          height: height * 0.05,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            // ignore: deprecated_member_use
            color: isSelected
                ? AppColors.black
                : AppColors.verylightblue.withOpacity(0.1),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: isSelected ? AppColors.white : AppColors.black,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildDetailRow(String title, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.grey),
      ),
      Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
    ],
  );
}

Widget _buildDescriptionSection(JobModel job) {
  // return Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     Text(
  //       'Job Description',
  //       style: TextStyle(
  //         fontSize: 18,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //     const SizedBox(height: 8),
  //     Text(
  //       // job.jobDescription ?? 'No description available',
  //       'this is a placeholder for job description',
  //       style: TextStyle(
  //         fontSize: 14,
  //         color: AppColors.grey,
  //         height: 1.5,
  //       ),
  //     ),
  //   ],
  // );
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Job Description',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
      ),
      const SizedBox(height: 8),

      // Text(
      //   job.jobDescription?? 'No description available',
      //   style: TextStyle(
      //     fontSize: 14,
      //     color: AppColors.grey,
      //     height: 1.5,
      //   ),
      // ),
    ],
  );
}

Widget _buildRequirementsSection(JobModel job) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Requirements',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      ..._buildBulletPoints(job.designation ?? 'No requirements specified'),
    ],
  );
}

Widget _buildBenefitsSection(JobModel job) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Benefits',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      // ..._buildBulletPoints(job.benefits ?? 'No benefits specified'),
      ..._buildBulletPoints('No benefits specified'),
    ],
  );
}

List<Widget> _buildBulletPoints(String text) {
  final points = text.split('\n').where((point) => point.trim().isNotEmpty);

  if (points.isEmpty) {
    return [
      Text('No information available', style: TextStyle(color: AppColors.grey)),
    ];
  }

  return points
      .map(
        (point) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: Text(
                  point.trim(),
                  style: TextStyle(color: AppColors.grey),
                ),
              ),
            ],
          ),
        ),
      )
      .toList();
}

Widget _buildApplyButton(BuildContext context, JobModel job) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
        _showApplyDialog(context, job);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightBlue,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Apply Now',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}

void _showApplyDialog(BuildContext context, JobModel job) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Apply for ${job.designation}'),
      content: Text(
        'Are you sure you want to apply for this position at ${job.companyName}?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Application submitted successfully!')),
            );
          },
          child: Text('Apply'),
        ),
      ],
    ),
  );
}

String _calculateTimeAgo(DateTime? postedDate) {
  if (postedDate == null) return 'Recently';

  final difference = DateTime.now().difference(postedDate);
  if (difference.inMinutes < 60) {
    return '${difference.inMinutes} min ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
  } else {
    return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
  }
}
