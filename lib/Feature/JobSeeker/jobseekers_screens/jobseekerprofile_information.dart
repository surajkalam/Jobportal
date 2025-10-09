// profile_information_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:jobapp/Feature/JobSeeker/modelclass/jobseeker_info.dart';
import 'package:jobapp/Feature/JobSeeker/provider/jobseeker_provider.dart';
import 'package:jobapp/core/util.dart/appcolors.dart';

class ProfileInformationScreen extends ConsumerStatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  ConsumerState<ProfileInformationScreen> createState() => _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends ConsumerState<ProfileInformationScreen> {
  @override
  Widget build(BuildContext context) {
    final jobseekerState = ref.watch(jobseekerProvider);
    final jobseekerInfo = jobseekerState.jobseekerInfo;
    
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profile Information',
          style: TextStyle(
            fontSize: 16,
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
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Please complete your profile',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.grey,
                        ),
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
                          _buildInfoRow('Full Name', jobseekerInfo.name),
                          _buildInfoRow('Email', jobseekerInfo.email),
                          _buildInfoRow('Contact', jobseekerInfo.contact),
                          _buildInfoRow('Date of Birth', jobseekerInfo.dateOfBirth),
                          _buildInfoRow('Age', '${jobseekerInfo.age} years'),
                        ],
                      ),
                      SizedBox(height: 16),
                      
                      // Professional Information Card
                      _buildInfoCard(
                        title: 'Professional Information',
                        icon: Icons.work_outline,
                        children: [
                          _buildInfoRow('Job Designation', jobseekerInfo.jobDesignation),
                          _buildInfoRow('Qualification', jobseekerInfo.qualification),
                          _buildInfoRow('Experience', jobseekerInfo.experience),
                          _buildInfoRow('Location', jobseekerInfo.location),
                        ],
                      ),
                      SizedBox(height: 16),
                      
                      // Resume Information Card
                      _buildInfoCard(
                        title: 'Resume',
                        icon: Icons.description_outlined,
                        children: [
                          if (jobseekerInfo.resumeUrl.isNotEmpty)
                            _buildResumeSection(jobseekerInfo)
                          else
                            _buildInfoRow('Resume', 'Not uploaded'),
                        ],
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
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey.withOpacity(0.3)),
        color: AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: AppColors.darkblue),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value.isNotEmpty ? value : 'Not specified',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResumeSection(JobseekerModel jobseekerInfo) {
    return Column(
      children: [
        _buildInfoRow('Resume File', jobseekerInfo.resumeFileName.isNotEmpty 
            ? jobseekerInfo.resumeFileName 
            : 'Resume'),
        SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () {
            // Open resume URL
            if (jobseekerInfo.resumeUrl.isNotEmpty) {
              // You can use url_launcher package to open the URL
              // launchUrl(Uri.parse(jobseekerInfo.resumeUrl));
            }
          },
          icon: Icon(Icons.download_outlined, size: 16),
          label: Text(
            'View Resume',
            style: TextStyle(fontSize: 12),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.lightBlue,
            foregroundColor: AppColors.white,
          ),
        ),
      ],
    );
  }
}