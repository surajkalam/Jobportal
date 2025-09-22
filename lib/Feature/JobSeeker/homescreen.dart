import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jobapp/Feature/JobSeeker/data/jobdata.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  int jobselected = 0;
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Iconsax.menu, color: colorScheme.onPrimary),
        actions: [
          SizedBox(width: width * 0.01),
          Icon(Iconsax.notification, color: colorScheme.onPrimary),
          SizedBox(width: width * 0.02),
          Icon(Iconsax.search_normal, color: colorScheme.onPrimary),
          SizedBox(width: width * 0.02),
        ],
        backgroundColor: colorScheme.onSecondary,
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.012),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: choicecontainer(
                    height,
                    width,
                    'Airline',
                    colorScheme,
                    textTheme,
                    selectedIndex == 1,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                  child: choicecontainer(
                    height,
                    width,
                    'Hospitality',
                    colorScheme,
                    textTheme,
                    selectedIndex == 2,
                  ),
                ),
              ],
            ),
            Expanded(
              child: selectedcontainer(
                height,
                width,
                selectedIndex,
                colorScheme,
                textTheme,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        jobselected = 0; // Set to the index of this tab
                      });
                    },
                    child: _selectedjobscontainer(
                      height,
                      width,
                      'Latest Jobs',
                      colorScheme,
                      textTheme,
                      jobselected == 0, // true if this tab is selected
                      jobselected,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        jobselected = 1; // Set to the index of this tab
                      });
                    },
                    child: _selectedjobscontainer(
                      height,
                      width,
                      'Top Jobs',
                      colorScheme,
                      textTheme,
                      jobselected == 1, // true if this tab is selected
                      jobselected,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        jobselected = 2; // Set to the index of this tab
                      });
                    },
                    child: _selectedjobscontainer(
                      height,
                      width,
                      'Filter',
                      colorScheme,
                      textTheme,
                      jobselected == 2, // true if this tab is selected
                      jobselected,
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

  Widget _selectedjobscontainer(
    double height,
    double width,
    String text,
    ColorScheme colorScheme,
    TextTheme textTheme,
    bool isSelected, 
    int jobselected,
  ) {
    return Padding(
      padding: EdgeInsets.all(width * 0.02),
      child: Container(
        height: height * 0.05,
        width: width * 0.27,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? colorScheme.primaryFixed : colorScheme.onPrimary,
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outlineVariant,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: textTheme.bodyLarge?.copyWith(
              color: isSelected ? colorScheme.onPrimary : colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget selectedcontainer(
    double height,
    double width,
    int index,
    ColorScheme colorscheme,
    TextTheme textTheme,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: (index == 1)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Airline Jobs',
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      // Display airline jobs
                      Column(
                        children: [
                          for (
                            int i = 0;
                            i < JobData.airlineJobs.length;
                            i += 2
                          )
                            Padding(
                              padding: EdgeInsets.only(bottom: height * 0.02),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: airlinejobscontainer(
                                      height,
                                      width,
                                      colorscheme,
                                      textTheme,
                                      JobData.airlineJobs[i],
                                    ),
                                  ),
                                  SizedBox(width: width * 0.02),
                                  if (i + 1 < JobData.airlineJobs.length)
                                    Expanded(
                                      child: airlinejobscontainer(
                                        height,
                                        width,
                                        colorscheme,
                                        textTheme,
                                        JobData.airlineJobs[i + 1],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  )
                : (index == 2)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hospitality Jobs',
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      // Display hospitality jobs
                      Column(
                        children: [
                          for (
                            int i = 0;
                            i < JobData.hospitalityJobs.length;
                            i += 2
                          )
                            Padding(
                              padding: EdgeInsets.only(bottom: height * 0.02),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: airlinejobscontainer(
                                      height,
                                      width,
                                      colorscheme,
                                      textTheme,
                                      JobData.hospitalityJobs[i],
                                    ),
                                  ),
                                  SizedBox(width: width * 0.02),
                                  if (i + 1 < JobData.hospitalityJobs.length)
                                    Expanded(
                                      child: airlinejobscontainer(
                                        height,
                                        width,
                                        colorscheme,
                                        textTheme,
                                        JobData.hospitalityJobs[i + 1],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.work_outline,
                          size: 50,
                          color: colorscheme.onSurface,
                        ),
                        SizedBox(height: height * 0.02),
                        Text(
                          'Select a category to view jobs',
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorscheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget airlinejobscontainer(
    double height,
    double width,
    ColorScheme colorscheme,
    TextTheme textTheme,
    Job job,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: colorscheme.onPrimary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: colorscheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: colorscheme.onPrimary,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: colorscheme.outlineVariant),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(job.imagePath),
                  ),
                ),
                SizedBox(width: width * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.designation,
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        job.companyName,
                        style: textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.015),
            Row(
              children: [
                Icon(Iconsax.location, color: colorscheme.secondary, size: 16),
                SizedBox(width: width * 0.01),
                Text(
                  job.location,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorscheme.secondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
            Row(
              children: [
                Icon(
                  Icons.business_center_outlined,
                  color: colorscheme.secondary,
                  size: 16,
                ),
                SizedBox(width: width * 0.01),
                Text(
                  job.experience,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorscheme.secondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.01),
            Row(
              children: [
                Icon(Iconsax.wallet, color: colorscheme.secondary, size: 16),
                SizedBox(width: width * 0.01),
                Text(
                  job.ctc,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorscheme.secondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.015),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Apply Now',
                  style: textTheme.labelMedium?.copyWith(
                    color: colorscheme.onSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget choicecontainer(
    double height,
    double width,
    String text,
    ColorScheme colorScheme,
    TextTheme textTheme,
    bool isSelected,
  ) {
    return Padding(
      padding: EdgeInsets.all(width * 0.02),
      child: Container(
        height: height * 0.05,
        width: width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? colorScheme.primaryFixed : colorScheme.onPrimary,
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outlineVariant,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: textTheme.bodyLarge?.copyWith(
              color: isSelected ? colorScheme.onPrimary : colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
