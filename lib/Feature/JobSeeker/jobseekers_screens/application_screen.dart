import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jobapp/core/util.dart/appcolors.dart';

// ignore: camel_case_types
class JobApplicationscreen extends StatefulWidget {
  const JobApplicationscreen({super.key});

  @override
  State<JobApplicationscreen> createState() => _JobApplicationscreenState();
}

class _JobApplicationscreenState extends State<JobApplicationscreen> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.faintbackblue, AppColors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.04, 0.3],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Column(
            children: [
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.only(
                  left: width * 0.02,
                  right: width * 0.025,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'search a job ..',
                    hintStyle: textTheme.bodySmall?.copyWith(
                      color: colorScheme.secondary,
                    ),
                    prefixIcon: Icon(Iconsax.search_normal),
                    labelText: 'search',
                    labelStyle: textTheme.bodySmall?.copyWith(
                      color: colorScheme.secondary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: colorScheme.surface,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: colorScheme.secondary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: colorScheme.onSecondary,
                        width: 2.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(
                  left: width * 0.02,
                  right: width * 0.025,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('My status')],
                ),
              ),
              detailsContainer(height, width),
              SizedBox(height: height*0.01,),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: AppColors.faintbackblue.withOpacity(0.1),
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.02,
                      right: width * 0.02,
                      top: height * 0.02,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('My applications'),
                        SizedBox(height: height * 0.005),
                        Expanded(
                          child: ListView(
                            children: [
                              applicationContainer(height, width),
                              SizedBox(height: height * 0.02),
                              applicationContainer(height, width),
                              SizedBox(height: height * 0.02),
                              applicationContainer(height, width),
                              SizedBox(height: height * 0.02),
                              applicationContainer(height, width),
                              SizedBox(height: height * 0.02),
                              applicationContainer(height, width),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailsContainer(double height, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: width * 0.024),
      child: Container(
        height:
            height * 0.12, // Slightly increased height to accommodate content
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 4),
              blurRadius: 5,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 12,
          ), // Reduced vertical padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '17 Jobs',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4), // Reduced spacing
                      Text(
                        'Applied',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '5 Jobs',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4), // Reduced spacing
                      Text(
                        'Shortlisted',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '4 Jobs',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4), // Reduced spacing
                      Text(
                        'Rejected',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget applicationContainer(double height, double width) {
    return Container(
      height: height * 0.2,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0, 4),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Software Engineer',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              children: [
                // ignore: deprecated_member_use
                Text(
                  'Congnizant | Banglore',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                Spacer(),
                Container(
                  height: height * 0.02,
                  width: width * 0.04,
                  decoration: BoxDecoration(
                    color: AppColors.faintbackblue,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Row(
              children: [
                // ignore: deprecated_member_use
                Icon(Icons.location_pin, size: 15, color: Colors.black),
                Text(
                  'Banglore',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                SizedBox(width: width * 0.02),
                Icon(Icons.wallet, size: 15, color: Colors.black),
                Text(
                  '5 -7 LPA',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 15, color: Colors.black),
                SizedBox(width: width * 0.02),
                Text('0 -2 years(s)', style: TextStyle(fontSize: 12)),
              ],
            ),
            SizedBox(height: height * 0.02),
            Padding(
              padding: EdgeInsets.only(left: width * 0.15),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // ignore: deprecated_member_use
                      color: Colors.greenAccent.withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.002,
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Icon(Icons.alarm, size: 12, color: Colors.green),
                            SizedBox(width: width * 0.01),
                            Text(
                              'posted 1 day ago',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                // ignore: deprecated_member_use
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.04),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // ignore: deprecated_member_use
                      color: AppColors.white,
                      border: BoxBorder.all(color: AppColors.black),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.002,
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons.alarm,
                              size: 12,
                              color: AppColors.darkblue,
                            ),
                            SizedBox(width: width * 0.01),
                            Text(
                              'posted 1 day ago',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                // ignore: deprecated_member_use
                                color: AppColors.darkblue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
