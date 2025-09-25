import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobapp/Feature/Recuiter/recuiter_model/jobupload_model.dart';
import 'package:jobapp/core/util.dart/appcolors.dart';

import '../provider/provider.dart';

class JobSeekerDashboard extends ConsumerWidget {
  const JobSeekerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final jobsAsync = ref.watch(filteredJobsProvider(selectedCategory));

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
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeSection(),
                SizedBox(height: 20),
                _buildSearchBar(),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    border: BoxBorder.all(
                      // ignore: deprecated_member_use
                      color: AppColors.grey.withOpacity(0.6),
                      width: 1.5
                    ),
                    color: AppColors.white,
                  ),
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        _buildCategorySection(categoriesAsync, ref),
                        const SizedBox(height: 20),
                        _buildJobMatchHeader(),
                        const SizedBox(height: 10),
                        _buildJobsList(jobsAsync),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        const Text(
          'David Robert Wilson',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Let\'s get you hired for the job you deserve!',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: TextStyle(color: Colors.grey[500]),
        prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.grey, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.lightBlue, width: 2), // Light blue when focused
        ),
      ),
    ),
  );
}

  Widget _buildCategorySection(
    AsyncValue<List<String>> categoriesAsync,
    WidgetRef ref,
  ) {
    return Container(
      // decoration: BoxDecoration(color: Colors.black),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Category',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: categoriesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text('Error: $error'),
              data: (categories) {
                final allCategories = ['All', ...categories];
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: allCategories.length,
                  itemBuilder: (context, index) {
                    final category = allCategories[index];
                    final isSelected =
                        ref.watch(selectedCategoryProvider) == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (selected) {
                          ref.read(selectedCategoryProvider.notifier).state =
                              category;
                        },
                        backgroundColor: Colors.grey[100],
                        selectedColor: Colors.blue[100],
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.blue : Colors.black,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobMatchHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Job match with you',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'See All',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildJobsList(AsyncValue<List<JobModel>> jobsAsync) {
  return jobsAsync.when(
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (error, stack) => Center(child: Text('Error: $error')),
    data: (jobs) {
      if (jobs.isEmpty) {
        return const Center(child: Text('No jobs available'));
      }

      return ListView.builder(
        shrinkWrap: true, // ADD THIS
        physics: const NeverScrollableScrollPhysics(), // ADD THIS
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          final job = jobs[index];
          return _buildJobCard(job);
        },
      );
    },
  );
}

  Widget _buildJobCard(JobModel job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey.withOpacity(0.8), width: 01),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.grey.withOpacity(0.3),
                width: 01,
              ),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.grey.withOpacity(0.05),
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: AppColors.grey),
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Colors.grey.withOpacity(0.05),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                job.imageUrl,
                                // height: 20,
                                // width: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                job.designation,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Spacer(),
                              SizedBox(width: 50),
                              Text(
                                '${job.ctc} ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${job.companyName} ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.location_pin,
                                size: 18,
                                color: AppColors.grey.withOpacity(0.8),
                              ),
                              Text(
                                ' ${job.location}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildJobTag('Remote'),
                      const SizedBox(width: 8),
                      _buildJobTag('Full-time'),

                      // _buildJobTag('${job.ctc}/month'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(Icons.alarm, color: AppColors.grey, size: 15),
                SizedBox(width: 5),
                Text(
                  '${_calculateTimeAgo(job.createdAt)} ago',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
                SizedBox(width: 20),
                Icon(Icons.person_2_outlined, color: AppColors.grey, size: 15),
                SizedBox(width: 4),
                Text(
                  '8 application',
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Text(
                    'URGENT',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: AppColors.grey.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
      ),
    );
  }

  String _calculateTimeAgo(DateTime? postedDate) {
    if (postedDate == null) return 'ASAP';

    final difference = DateTime.now().difference(postedDate);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''}';
    } else {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''}';
    }
  }
}
