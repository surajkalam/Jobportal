import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jobapp/Feature/Recuiter/recuiter_model/jobupload_model.dart';
import 'package:jobapp/core/util.dart/appcolors.dart';

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
            height: height * 0.05,
            width: width * 0.11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
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
                  size: 18,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.02),
            child: Container(
              height: height * 0.05,
              width: width * 0.11,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
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
                    size: 18,
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
                jdcontainer('Delhi', width, height),
                jdcontainer('3-4 YoE', width, height),
                jdcontainer(' 18–27 years', width, height),
              ],
            ),
            SizedBox(height: height * 0.02),
            selectinfocontainer(context, width, height, ref),
            SizedBox(height: height * 0.01),

            // Job Details Section
            // _buildJobDetails(job),
            SizedBox(height: height * 0.02),

            // Job Description
            _buildDescriptionSection(job, height, width),
            SizedBox(height: 20),

            // Requirements
            _buildRequirementsSection(job, height, width),
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
      padding: EdgeInsets.all(width * 0.018),
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
              padding: EdgeInsets.all(width * 0.006),
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
          SizedBox(width: width * 0.02),
          Expanded(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.designation,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          job.companyName,
                          style: TextStyle(fontSize: 12, color: AppColors.grey),
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
                          style: TextStyle(color: AppColors.grey, fontSize: 12),
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
        horizontal: width * 0.012,
      ),
      child: Container(
        padding: EdgeInsets.all(width * 0.016),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: AppColors.lightblue.withOpacity(0.3),
          // ignore: deprecated_member_use
          border: Border.all(color: AppColors.grey.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 08,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  // Widget _buildJobDetails(JobModel job) {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: AppColors.grey.withOpacity(0.3)),
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Column(
  //       children: [
  //         _buildDetailRow('Salary', '${job.ctc}'),
  //         const SizedBox(height: 12),
  //         // _buildDetailRow('Employment Type', job.employmentType ?? 'Full-time'),
  //         _buildDetailRow('Employee time', 'Full-time'),
  //         const SizedBox(height: 12),
  //         // _buildDetailRow('Experience', job.experienceRequired ?? 'Not specified'),
  //         _buildDetailRow('Experience', 'Not specified'),
  //         const SizedBox(height: 12),
  //         _buildDetailRow('Posted', _calculateTimeAgo(job.createdAt)),
  //       ],
  //     ),
  //   );
  // }

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
          height: height * 0.04,
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
                fontSize: 09,
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

// Widget _buildDetailRow(String title, String value) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Text(
//         title,
//         style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.grey),
//       ),
//       Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
//     ],
//   );
// }

Widget _buildDescriptionSection(JobModel job, double height, double width) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Job Description',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ),
      SizedBox(height: height * 0.01),
      Text(
        '''
A job description (JD) is a brief written description of the role and responsibilities, educational qualifications, and tasks that are required for a particular position. A job description is the first point of contact between a company and a candidate. A good JD always helps the organization find a good, qualified candidate for the job role. A JD tells about the designation, salary range, role, responsibilities, skills required for the job, job location, and environmental pressures that apply to the position. Below is the list of all Job Descriptions formatted and structured on the basis of Job Profile.
''',
        style: TextStyle(
          fontSize: 08,
          fontWeight: FontWeight.w500,
          // ignore: deprecated_member_use
          color: AppColors.black.withOpacity(0.7),
        ),
      ),
    ],
  );
}

Widget _buildRequirementsSection(JobModel job, double height, double width) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Requirements',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      SizedBox(height: height * 0.01),
      ..._buildBulletPoints(
        '10+2 (Higher Secondary) or equivalent (some airlines prefer graduates)',
      ),
      ..._buildBulletPoints(
        'Fluent in English (and sometimes Hindi or local language)',
      ),
      ..._buildBulletPoints('Usually 18–26 years '),
      ..._buildBulletPoints(
        'Generally minimum 155–170 cm (varies by airline); proportionate weight',
      ),
      ..._buildBulletPoints('Normal or corrected vision (usually 6/6)'),
      ..._buildBulletPoints('Medically fit; no visible tattoos/scars '),
    ],
  );
}

Widget _buildBenefitsSection(JobModel job) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Benefits',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 8),
      // ..._buildBulletPoints(job.benefits ?? 'No benefits specified')
      ..._buildBulletPoints(
        'You can travel domestically and internationally, depending on the airline.',
      ),
      ..._buildBulletPoints(
        'Some even allow standby travel on partner airlines.',
      ),
      ..._buildBulletPoints('Night shift, layover, and meal allowances.'),
      ..._buildBulletPoints(
        'Ground staff and engineers get structured salary increments and benefits over time.',
      ),
      ..._buildBulletPoints(
        'Meals or daily allowances are also provided when flying or on duty.',
      ),
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
              Text(
                '• ',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
              ),
              Expanded(
                child: Text(
                  point.trim(),
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 09,
                  ),
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
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Apply Now',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
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
      title: Text(
        'Apply for ${job.designation}',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      content: Text(
        'Are you sure you want to apply for this position at ${job.companyName}?',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Application submitted successfully!')),
            );
          },
          child: Text(
            'Apply',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
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
