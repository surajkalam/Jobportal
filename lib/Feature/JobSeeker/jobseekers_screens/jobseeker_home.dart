import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jobapp/Feature/combomodel/jobupload_model.dart';
import 'package:jobapp/core/util.dart/appcolors.dart';

import '../provider/provider.dart';

class JobSeekerDashboard extends ConsumerStatefulWidget {
  const JobSeekerDashboard({super.key});

  @override
  ConsumerState<JobSeekerDashboard> createState() => _JobSeekerDashboardState();
}

class _JobSeekerDashboardState extends ConsumerState<JobSeekerDashboard> {
 final TextEditingController _searchController = TextEditingController();
 @override
  void initState() {
    super.initState();
    // Listen to search query changes and update controller
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    // Update provider only when text actually changes
    if (_searchController.text != ref.read(searchQueryProvider)) {
      ref.read(searchQueryProvider.notifier).state = _searchController.text;
    }
  }

@override
Widget build(BuildContext context) {
  final ref = this.ref;
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  final selectedCategory = ref.watch(selectedCategoryProvider);
  // final categoriesAsync = ref.watch(categoriesProvider);
  // final jobsAsync = ref.watch(filteredJobsProvider(selectedCategory));
  final searchQuery = ref.watch(searchQueryProvider);

  // Decide which provider to use based on whether user is searching
  final jobsAsync = searchQuery.isEmpty
      ? ref.watch(filteredJobsProvider(selectedCategory)) // Use category filter
      : ref.watch(searchOnlyProvider); // Use search results

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
              _buildWelcomeSection(height, width),
              SizedBox(height: height * 0.02),
              _buildSearchBar(height, width),
              SizedBox(height: height * 0.02),
              // Only show category section when not searching
              if (searchQuery.isEmpty) ...[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    border: BoxBorder.all(
                      // ignore: deprecated_member_use
                      color: AppColors.grey.withOpacity(0.6),
                      width: 1.5,
                    ),
                    color: Colors.transparent,
                  ),
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        _buildCategorySection(ref, height, width),
                        _buildJobMatchHeader(),
                        _buildJobsList(jobsAsync, selectedCategory, height, width),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                // When searching, show search results in a simpler container
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      // ignore: deprecated_member_use
                      color: AppColors.grey.withOpacity(0.6),
                      width: 1.5,
                    ),
                    color: Colors.transparent,
                  ),
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        _buildSearchHeader(searchQuery, context),
                        _buildJobsList(jobsAsync, "Search Results", height, width),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    ),
  );
}
Widget _buildSearchHeader(String searchQuery,BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Search Results for "$searchQuery"',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      IconButton(
        icon: Icon(Icons.close, size: 20),
        onPressed: () {
          // Clear search when close button is pressed
          final ref = ProviderScope.containerOf(context);
          ref.read(searchQueryProvider.notifier).state = '';
        },
      ),
    ],
  );
}
  Widget _buildWelcomeSection(double height, double width) {
    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.05,
        right: width * 0.02,
        top: height * 0.04,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),

          const Text(
            'David Robert Wilson',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
          ),
          Text(
            'Let\'s get you hired for the job you deserve!',
            style: TextStyle(fontSize: 10, color: AppColors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(double height, double width) {
  return Consumer(
    builder: (context, ref, child) {
      final searchQuery = ref.watch(searchQueryProvider);
      // Sync controller with provider value (only if different)
      if (_searchController.text != searchQuery) {
        _searchController.text = searchQuery;
      }
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          controller: _searchController, // Use the same controller
          decoration: InputDecoration(
            hintText: 'Search by company, location, designation...',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
            prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
            suffixIcon: searchQuery.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear, size: 16),
                    onPressed: () {
                      _searchController.clear();
                    },
                  )
                : null,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
              borderSide: BorderSide(
                color: Colors.lightBlue,
                width: 2,
              ),
            ),
          ),
        ),
      );
    },
  );
}
  Widget _buildCategorySection(WidgetRef ref, double height, double width) {
    final staticCats = ref.watch(staticCategoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: height * 0.012),
        SizedBox(
          height: height * 0.04,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: staticCats.length + 1, // +1 for "All" category
            itemBuilder: (context, index) {
              final category = index == 0 ? 'All' : staticCats[index - 1];
              final isSelected = selectedCategory == category;
              return Padding(
                padding: EdgeInsets.only(right: width * 0.02),
                child: FilterChip(
                  label: Text(
                    category,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    ref.read(selectedCategoryProvider.notifier).state =
                        category;
                  },
                  shape: StadiumBorder(
                    // ignore: deprecated_member_use
                    side: BorderSide(color: AppColors.grey.withOpacity(0.5)),
                  ),
                  backgroundColor: isSelected
                      ? AppColors.white
                      : AppColors.black,
                  selectedColor: AppColors.lightGrey,
                  labelStyle: TextStyle(
                    color: isSelected ? AppColors.black : AppColors.grey,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildJobMatchHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Job match with you',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'See All',
            style: TextStyle(
              fontSize: 11,
              color: Colors.blue,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJobsList(
    AsyncValue<List<JobModel>> jobsAsync,
    String selectedCategory,
    double height,double width
  ) {
    return jobsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (jobs) {
        if (jobs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 50, color: Colors.grey[400]),
                SizedBox(height: 10),
                Text(
                  selectedCategory == 'All'
                      ? 'No jobs available'
                      : 'No $selectedCategory jobs found',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            final job = jobs[index];
            return _buildJobCard(context, job);
          },
        );
      },
    );
  }

  Widget _buildJobCard(BuildContext context, JobModel job) {
    return InkWell(
      onTap: () {
        context.push('/job-details', extra: job);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          // ignore: deprecated_member_use
          border: Border.all(color: AppColors.grey.withOpacity(0.8), width: 01),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
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
                  // ignore: deprecated_member_use
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
                padding: EdgeInsets.all(10.0),
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
                              padding: EdgeInsets.all(2.0),
                              child: ClipRRect(
                                clipBehavior: Clip.antiAlias,
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  job.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.broken_image, color: Colors.grey);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    job.designation,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  '${job.ctc} ',
                                  style: TextStyle(
                                    fontSize: 09,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${job.companyName} ',
                                  style: TextStyle(
                                    fontSize: 09,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.location_pin,
                                  size: 15,
                                  // ignore: deprecated_member_use
                                  color: AppColors.grey.withOpacity(0.8),
                                ),
                                Text(
                                  ' ${job.location}',
                                  style: TextStyle(
                                    fontSize: 09,
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
                        _buildJobTag('full Time'),
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
                    style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                  ),
                  SizedBox(width: 20),
                  Icon(
                    Icons.person_2_outlined,
                    color: AppColors.grey,
                    size: 15,
                  ),
                  SizedBox(width: 4),
                  Text(
                    '8 application',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 8,

                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  if (job.isUrgentHiring)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.grey.withOpacity(0.05),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Text(
                      'URGENT',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
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
        style: TextStyle(fontSize: 10, color: Colors.grey[700]),
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
