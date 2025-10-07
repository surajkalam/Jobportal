import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/util.dart/appcolors.dart';

class JobseekerProfileScreen extends ConsumerStatefulWidget {
  const JobseekerProfileScreen({super.key});

  @override
  ConsumerState<JobseekerProfileScreen> createState() => _YourScreenState();
}

class _YourScreenState extends ConsumerState<JobseekerProfileScreen> {
  @override
  Widget build(BuildContext context) {
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
                child: buildheadercontainer(height, width),
              ),
              SizedBox(height: height * 0.02),
              buildacountsession(height, width),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildheadercontainer(double height, double width) {
    return Container(
      height: height * 0.2,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.grey),
        // ignore: deprecated_member_use
        gradient: LinearGradient(
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
                  children: [
                    Padding(padding: EdgeInsetsGeometry.only(top: height * 0.01)),
                    Text(
                      'Kalamkar Suraj Pandurang ',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Designer Manager',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(width: width * 0.04),
                        // Icon(Iconsax.more_circle),
                        Text(
                          'Walmart',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
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
            color: AppColors.white.withOpacity(0.5),
          ),
          Row(
            children: [
              buildemailheadercontainer(
                height,
                width,
                'surajkalamkar@walmart.com',
              ),
              buildemailheadercontainer(height, width, '87665748983'),
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
          border: Border.all(color: AppColors.grey),
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

  Widget buildacountsession(double height, double width) {
    return Container(
      height: height * 0.78,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white,
        border: Border.all(color: AppColors.grey),
        // ignore: deprecated_member_use
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
                    // Row 1: Profile Information
                    _buildAccountRow(
                      icon: Icons.person_outline,
                      title: 'Profile Information',
                      subtitle: '',
                      hasArrow: true,
                      width: width,
                    ),
                    // ignore: deprecated_member_use
                    Divider(color: AppColors.grey.withOpacity(0.3)),
                    // Row 2: Email
                    _buildAccountRow(
                      icon: Icons.email_outlined,
                      title: 'Email',
                      subtitle: 'verify',
                      hasArrow: true,
                      width: width,
                    ),
                    // ignore: deprecated_member_use
                    Divider(color: AppColors.grey.withOpacity(0.3)),
            
                    _buildAccountRow(
                      icon: Iconsax.heart,
                      title: 'Age',
                      subtitle: '25 years',
                      hasArrow: true,
                      width: width,
                    ),
                    // ignore: deprecated_member_use
                    Divider(color: AppColors.grey.withOpacity(0.3)),
                    _buildAccountRow(
                      icon: Icons.work_outline,
                      title: 'Profession',
                      subtitle: 'Marketing Manager',
                      hasArrow: true,
                      width: width,
                    ),
                    // ignore: deprecated_member_use
                    Divider(color: AppColors.grey.withOpacity(0.3)),
                    // Row 5: Logout
                    _buildAccountRow(
                      icon: Iconsax.logout_14,
                      title: 'Logout',
                      subtitle: '',
                      hasArrow: true, // No arrow for logout
                      textColor: Colors.red,
                      width: width,
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
  }) {
    return GestureDetector(
      onTap: () {
        // Add onTap functionality for each row
      },
      child: Container(
        padding:EdgeInsets.all(10),
        child: Row(
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 25, color: textColor),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Row(
                children: [
                  // Title
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  Spacer(),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontFamily: 'italic',
                        fontSize: 10,
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
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              // color: AppColors.black
            ),
          ),
          Spacer(),
          Container(
            height: height * 0.05,
            width: width * 0.11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70),
              border: Border.all(color: AppColors.grey),
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
