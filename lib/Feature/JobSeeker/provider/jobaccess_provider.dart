import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:jobapp/Feature/JobSeeker/firebase_crud/jobaccess_repository.dart';
import 'package:jobapp/Feature/Recuiter/recuiter_model/jobupload_model.dart';
final List<String> staticCategories = [
  'Trainer',
  'Wedding planner',
  'Casino manager',
  'Travel agent',
  'Airline cabin crew',
  'Event tour coordinator',
  'Waiter / Waitress',
  'Receptionist',
  'Hotel manager',
  'Reservation agent',
  'Java',
  'Flutter'
];

// Repository provider
final jobRepositoryProvider = Provider<JobRepository>((ref) {
  return JobRepository();
});

// Provider for all active jobs
final jobsProvider = StreamProvider<List<JobModel>>((ref) {
  final repository = ref.watch(jobRepositoryProvider);
  return repository.getActiveJobs();
});

// Provider for filtered jobs by category
final filteredJobsProvider = StreamProvider.family<List<JobModel>, String>((ref, category) {
  final repository = ref.watch(jobRepositoryProvider);
  if (category == 'All') {
    return repository.getActiveJobs();
  }
  return repository.getJobsByCategory(category);
});

// Provider for available categories
final categoriesProvider = StreamProvider<List<String>>((ref) {
  final repository = ref.watch(jobRepositoryProvider);
  return repository.getAvailableCategories();
});

// Provider for selected category
final selectedCategoryProvider = StateProvider<String>((ref) => 'All');