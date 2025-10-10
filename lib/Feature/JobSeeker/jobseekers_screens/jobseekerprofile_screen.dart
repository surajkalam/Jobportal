// Updated JobseekerProfileScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jobapp/Feature/JobSeeker/jobseekers_screens/jobseekerprofile_information.dart';
import 'package:jobapp/Feature/JobSeeker/modelclass/jobseeker_info.dart';
import 'package:jobapp/Feature/JobSeeker/provider/jobseeker_provider.dart';
import 'package:jobapp/core/util.dart/appcolors.dart';

class JobseekerProfileScreen extends ConsumerStatefulWidget {
  const JobseekerProfileScreen({super.key});

  @override
  ConsumerState<JobseekerProfileScreen> createState() => _YourScreenState();
}

class _YourScreenState extends ConsumerState<JobseekerProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Load jobseeker info when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(jobseekerProvider.notifier).loadJobseekerInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final jobseekerState = ref.watch(jobseekerProvider);
    final jobseekerInfo = jobseekerState.jobseekerInfo;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.faintbackblue, AppColors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.04, 0.3],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: buildstartingrow(height, width),
              ),
              SizedBox(height: height * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: buildheadercontainer(height, width, jobseekerInfo),
              ),
              SizedBox(height: height * 0.02),
              buildacountsession(height, width, jobseekerInfo),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildheadercontainer(
    double height,
    double width,
    JobseekerModel? jobseekerInfo,
  ) {
    return Container(
      height: height * 0.2,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.grey),
        gradient: LinearGradient(
          // ignore: deprecated_member_use
          colors: [AppColors.darkblue.withOpacity(0.6), AppColors.darkblue],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.1, 0.6],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: height * 0.024,
                  left: width * 0.05,
                  right: width * 0.06,
                ),
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColors.darkblue),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(
                      image: NetworkImage(
                        'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?cs=srgb&dl=pexels-chloe-1043471.jpg&fm=jpg',
                      ),
                      height: height * 0.063,
                      width: width * 0.14,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: height * 0.01)),
                    Text(
                      jobseekerInfo?.name.isNotEmpty == true
                          ? jobseekerInfo!.name
                          : 'Your Name',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: height * 0.008),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width * 0.3,
                          child: Text(
                            jobseekerInfo?.jobDesignation.isNotEmpty == true
                                ? jobseekerInfo!.jobDesignation
                                : 'Designation',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: width * 0.04),
                        SizedBox(
                          width: width * 0.26,
                          child: Column(
                            children: [
                              Text(
                                jobseekerInfo?.location.isNotEmpty == true
                                    ? jobseekerInfo!.location
                                    : 'Location',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.03),
          Divider(
            height: height * 0.01,
            // ignore: deprecated_member_use
            color: AppColors.white.withOpacity(0.5),
          ),
          Row(
            children: [
              buildemailheadercontainer(
                height,
                width,
                jobseekerInfo?.email.isNotEmpty == true
                    ? jobseekerInfo!.email
                    : 'your@email.com',
              ),
              buildemailheadercontainer(
                height,
                width,
                jobseekerInfo?.contact.isNotEmpty == true
                    ? jobseekerInfo!.contact
                    : 'Contact Number',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildemailheadercontainer(double height, double width, String text) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.02, left: width * 0.02),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.white),
          // ignore: deprecated_member_use
          color: AppColors.white.withOpacity(0.1),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: AppColors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildacountsession(
    double height,
    double width,
    JobseekerModel? jobseekerInfo,
  ) {
    return Container(
      height: height * 0.78,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white,
        border: Border.all(color: AppColors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: height * 0.01),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.transparent,
                border: Border.all(color: AppColors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    // Row 1: Profile Information - WITH ACTION
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileInformationScreen(),
                          ),
                        );
                      },
                      child: _buildAccountRow(
                        icon: Icons.person_outline,
                        title: 'Profile Information',
                        subtitle: 'View and edit',
                        hasArrow: true,
                        width: width,
                        height: height,
                      ),
                    ),
                    // ignore: deprecated_member_use
                    Divider(color: AppColors.grey.withOpacity(0.3)),

                    // Row 2: Email - NO ACTION
                    _buildAccountRow(
                      icon: Icons.email_outlined,
                      title: 'Email',
                      subtitle: jobseekerInfo?.email.isNotEmpty == true
                          ? jobseekerInfo!.email
                          : 'Not set',
                      hasArrow: false, // No arrow for email
                      width: width,
                      height: height,
                    ),
                    // ignore: deprecated_member_use
                    Divider(color: AppColors.grey.withOpacity(0.3)),

                    // Row 3: Age - NO ACTION
                    _buildAccountRow(
                      icon: Iconsax.heart,
                      title: 'Age',
                      subtitle:
                          jobseekerInfo?.age != null && jobseekerInfo!.age > 0
                          ? '${jobseekerInfo.age} years'
                          : 'Not set',
                      hasArrow: false,
                      width: width,
                      height: height,
                    ),
                    // ignore: deprecated_member_use
                    Divider(color: AppColors.grey.withOpacity(0.3)),

                    // Row 4: Profession - NO ACTION
                    _buildAccountRow(
                      icon: Icons.work_outline,
                      title: 'Profession',
                      subtitle: jobseekerInfo?.jobDesignation.isNotEmpty == true
                          ? jobseekerInfo!.jobDesignation
                          : 'Not set',
                      hasArrow: false, // No arrow for profession
                      width: width,
                      height: height,
                    ),
                    // ignore: deprecated_member_use
                    Divider(color: AppColors.grey.withOpacity(0.3)),

                    // Row 5: Logout - WITH ACTION
                    GestureDetector(
                      onTap: () {
                        _showLogoutDialog(context);
                      },
                      child: _buildAccountRow(
                        icon: Iconsax.logout_14,
                        title: 'Logout',
                        subtitle: '',
                        hasArrow: true,
                        textColor: Colors.red,
                        width: width,
                        height: height,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.2),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool hasArrow,
    Color textColor = Colors.black,
    required double width,
    required double height,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: width * 0.07,
            height: height * 0.03,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, size: 18, color: textColor),
          ),
          SizedBox(width: width * 0.012),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.38,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 09,
                      color: AppColors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          SizedBox(width: width * 0.01),
          if (hasArrow)
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.grey),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Add your logout logic here
            },
            child: Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget buildstartingrow(double height, double width) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.03),
      child: Row(
        children: [
          Text(
            'Profile',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Container(
            height: height * 0.05,
            width: width * 0.11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70),
              border: Border.all(color: AppColors.grey),
              // ignore: deprecated_member_use
              color: AppColors.white.withOpacity(0.9),
            ),
            child: Center(
              child: Icon(
                Icons.share_outlined,
                size: 20,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
