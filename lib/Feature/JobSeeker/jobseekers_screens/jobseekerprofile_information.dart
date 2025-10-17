// profile_information_screen.dart
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobapp/Feature/combomodel/resumeview_screen.dart';

import 'package:jobapp/Feature/JobSeeker/modelclass/jobseeker_info.dart';
import 'package:jobapp/Feature/JobSeeker/provider/jobseeker_provider.dart';
import 'package:jobapp/core/util/appcolors.dart';


import '../service.dart/pdf_uploadservice.dart' show pdfUploadServiceProvider;

class ProfileInformationScreen extends ConsumerStatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  ConsumerState<ProfileInformationScreen> createState() =>
      _ProfileInformationScreenState();
}

class _ProfileInformationScreenState
    extends ConsumerState<ProfileInformationScreen> {
  @override
  Widget build(BuildContext context) {
    log('Building ProfileInformationScreen');
    final jobseekerState = ref.watch(jobseekerProvider);
    final jobseekerInfo = jobseekerState.jobseekerInfo;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
         backgroundColor: AppColors.faintbackblue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profile Information',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: jobseekerState.isLoading
          ? Center(child: CircularProgressIndicator())
          : jobseekerInfo == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_outline, size: 64, color: AppColors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No Profile Information',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(height: height * 0.009),
                  Text(
                    'Please complete your profile',
                    style: TextStyle(fontSize: 14, color: AppColors.grey),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Personal Information Card
                  _buildInfoCard(
                    title: 'Personal Information',
                    icon: Icons.person_outline,
                    children: [
                      _buildInfoRow(
                        'Full Name :',
                        jobseekerInfo.name,
                        height,
                        width,
                      ),
                      _buildInfoRow(
                        'Email :',
                        jobseekerInfo.email,
                        height,
                        width,
                      ),
                      _buildInfoRow(
                        'Contact :',
                        jobseekerInfo.contact,
                        height,
                        width,
                      ),
                      _buildInfoRow(
                        'Date of Birth :',
                        jobseekerInfo.dateOfBirth,
                        height,
                        width,
                      ),
                      _buildInfoRow(
                        'Age :',
                        '${jobseekerInfo.age} years',
                        height,
                        width,
                      ),
                    ],
                    context: context,
                    height: height,
                    width: width,
                  ),
                  SizedBox(height: 16),
                  // Professional Information Card
                  _buildInfoCard(
                    title: 'Professional Information',
                    icon: Icons.work_outline,
                    children: [
                      _buildInfoRow(
                        'Job Designation :',
                        jobseekerInfo.jobDesignation,
                        height,
                        width,
                      ),
                      _buildInfoRow(
                        'Qualification :',
                        jobseekerInfo.qualification,
                        height,
                        width,
                      ),
                      _buildInfoRow(
                        'Experience :',
                        jobseekerInfo.experience,
                        height,
                        width,
                      ),
                      _buildInfoRow(
                        'Location :',
                        jobseekerInfo.location,
                        height,
                        width,
                      ),
                    ],
                    context: context,
                    height: height,
                    width: width,
                  ),
                  SizedBox(height: 16),
                  // Resume Information Card
                  _buildInfoCard(
                    title: 'Resume ',
                    icon: Icons.description_outlined,
                    children: [
                      if (jobseekerInfo.resumeUrl.isNotEmpty)
                        _buildResumeSection(
                          jobseekerInfo,
                          context,
                          height,
                          width,
                        )
                      else
                        _buildInfoRow('Resume', 'Not uploaded', height, width),
                    ],
                    context: context,
                    height: height,
                    width: width,
                  ),
                ],
              ),
            ),
    );
  }
  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
    required BuildContext context,
    required double height,
    required double width,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // ignore: deprecated_member_use
        border: Border.all(color: AppColors.grey.withOpacity(0.3)),
        color: AppColors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: AppColors.darkblue),
                SizedBox(width: width * 0.025),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.015),
            ...children,
          ],
        ),
      ),
    );
  }
  Widget _buildInfoRow(
    String label,
    String value,
    double height,
    double width,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.009),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.grey,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value.isNotEmpty ? value : 'Not specified',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildResumeSection(
    JobseekerModel jobseekerInfo,
    BuildContext context,
    double height,
    double width,
  ) {
    final hasResume = jobseekerInfo.resumeUrl.isNotEmpty;
    return Column(
      children: [
        _buildInfoRow(
          'Resume File',
          hasResume ? jobseekerInfo.resumeFileName : 'No resume uploaded',
          height,
          width,
        ),
        SizedBox(height: 8),
        // Resume Actions Row
        Row(
          children: [
            // View/Upload Resume Button
            Expanded(
              child: ElevatedButton.icon(
                onPressed: hasResume
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResumeViewerScreen(
                              resumeUrl: jobseekerInfo.resumeUrl,
                              resumeFileName: jobseekerInfo.resumeFileName,
                            ),
                          ),
                        );
                      }
                    : _uploadResumeWithProvider, // Use provider method for upload
                icon: Icon(
                  hasResume ? Icons.visibility_outlined : Icons.upload,
                  size: 16,
                ),
                label: Text(
                  hasResume
                      // ? 'View ${jobseekerInfo.resumeFileName}'
                      ? 'View'
                      : 'Upload Resume',
                  style: TextStyle(fontSize: 12),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.darkblue,
                  // ignore: deprecated_member_use
                  side: BorderSide(color: AppColors.darkblue.withOpacity(0.6)),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
            // Edit and Delete Buttons (only show if resume exists)
            if (hasResume) ...[
              SizedBox(width: 8),
              // Edit Button
              SizedBox(
                width: 40,
                height: 40,
                child: ElevatedButton(
                  onPressed:
                      _uploadResumeWithProvider, // Use provider method for edit
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightBlue,
                    foregroundColor: AppColors.white,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Icon(Icons.edit, size: 16),
                ),
              ),
              SizedBox(width: 4),

              // Delete Button
              SizedBox(
                width: 40,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    _showDeleteResumeDialog(jobseekerInfo);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Icon(Icons.delete_outline, size: 16),
                ),
              ),
            ],
          ],
        ),

        // Show resume URL if exists
        // if (hasResume)
        //   Padding(
        //     padding: EdgeInsets.only(top: 4),
        //     child: Text(
        //       'Resume URL: ${jobseekerInfo.resumeUrl}',
        //       style: TextStyle(fontSize: 9, color: Colors.blue),
        //       overflow: TextOverflow.ellipsis,
        //     ),
        //   ),
      ],
    );
  }
  Future<void> _uploadResumeWithProvider() async {
    try {
      final pdfService = ref.read(pdfUploadServiceProvider);

      // Pick PDF file using your existing service
      final File? pdfFile = await pdfService.pickPdf();
      if (pdfFile == null) return;
      // ignore: use_build_context_synchronously
      _showSnackBar(context: context, text: 'Uploading resume...');
      await ref.read(jobseekerProvider.notifier).uploadResume(pdfFile);
      // ignore: use_build_context_synchronously
      _showSnackBar(context: context, text: 'Resume uploaded successfully!');
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload resume: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
  void _showDeleteResumeDialog(JobseekerModel jobseekerInfo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Resume',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Are you sure you want to delete your resume "${jobseekerInfo.resumeFileName}"? This action cannot be undone.',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(fontSize: 14)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _deleteResume();
            },
            child: Text(
              'Delete',
              style: TextStyle(fontSize: 14, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _deleteResume() async {
    try {
      await ref.read(jobseekerProvider.notifier).deleteResume();
      // ignore: use_build_context_synchronously
      _showSnackBar(context: context, text: 'Resume deleted successfully');
    } catch (e) {
      // ignore: use_build_context_synchronously
      _showSnackBar(
        // ignore: use_build_context_synchronously
        context: context,
        text: 'Resume deleted successfully',
        textColor: Colors.red,
      );
    }
  }
  void _showSnackBar({
    required BuildContext context,
    required String text,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.green,
    Duration duration = const Duration(seconds: 2),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, style: TextStyle(color: textColor)),
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
