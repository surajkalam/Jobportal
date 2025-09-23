// providers/job_provider.dart
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:jobapp/Feature/Recuiter/recuiter_firebase/jobupload_firebase.dart';
import 'package:jobapp/Feature/Recuiter/recuiter_model/jobupload_model.dart';

// Firebase Service Provider
final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService();
});

// Simple state class for job operations
class JobState {
  final bool isLoading;
  final String? error;
  final bool success;
  final int totalJobsCount;

  const JobState({
    this.isLoading = false,
    this.error,
    this.success = false,
    this.totalJobsCount = 0,
  });

  JobState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
    int? totalJobsCount,
  }) {
    return JobState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      success: success ?? this.success,
      totalJobsCount: totalJobsCount ?? this.totalJobsCount,
    );
  }
}

// Job Notifier
class JobNotifier extends StateNotifier<JobState> {
  final FirebaseService _firebaseService;

  JobNotifier(this._firebaseService) : super(const JobState());

  Future<String> uploadImage(File imageFile) async {
    try {
      return await _firebaseService.uploadImage(imageFile);
    } catch (e) {
      state = state.copyWith(error: 'Image upload failed: $e');
      rethrow;
    }
  }

  Future<void> saveJob(JobModel jobData) async {
    state = state.copyWith(isLoading: true, error: null, success: false);
    
    try {
      await _firebaseService.saveJobData(jobData);
      state = state.copyWith(isLoading: false, success: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to save job: $e');
      rethrow;
    }
  }

  // Toggle job active status
  Future<void> toggleJobStatus(String jobId, bool currentStatus) async {
    try {
      await _firebaseService.updateJobStatus(jobId, !currentStatus);
    } catch (e) {
      state = state.copyWith(error: 'Failed to update job status: $e');
      rethrow;
    }
  }

  // Update total jobs count
  void updateTotalJobsCount(int count) {
    state = state.copyWith(totalJobsCount: count);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearSuccess() {
    state = state.copyWith(success: false);
  }
}

// Job Notifier Provider
final jobNotifierProvider = StateNotifierProvider<JobNotifier, JobState>((ref) {
  final firebaseService = ref.read(firebaseServiceProvider);
  return JobNotifier(firebaseService);
});

// Stream providers
final airlineJobsProvider = StreamProvider<List<JobModel>>((ref) {
  final firebaseService = ref.read(firebaseServiceProvider);
  return firebaseService.getJobsByCategory('Airline');
});

final hospitalityJobsProvider = StreamProvider<List<JobModel>>((ref) {
  final firebaseService = ref.read(firebaseServiceProvider);
  return firebaseService.getJobsByCategory('Hospitality');
});

final allJobsProvider = StreamProvider<List<JobModel>>((ref) {
  final firebaseService = ref.read(firebaseServiceProvider);
  return firebaseService.getAllJobs();
});

// Active jobs only provider
final activeJobsProvider = StreamProvider<List<JobModel>>((ref) {
  final firebaseService = ref.read(firebaseServiceProvider);
  return firebaseService.getActiveJobs();
});

// Total jobs count provider
final totalJobsCountProvider = StreamProvider<int>((ref) {
  final firebaseService = ref.read(firebaseServiceProvider);
  return firebaseService.getTotalJobsCount();
});

// Job status toggle provider
final jobStatusProvider = StateNotifierProvider.family<JobStatusNotifier, AsyncValue<bool>, String>((ref, jobId) {
  final firebaseService = ref.read(firebaseServiceProvider);
  return JobStatusNotifier(firebaseService, jobId);
});

class JobStatusNotifier extends StateNotifier<AsyncValue<bool>> {
  final FirebaseService _firebaseService;
  final String jobId;

  JobStatusNotifier(this._firebaseService, this.jobId) : super(const AsyncValue.loading()) {
    _loadInitialStatus();
  }

  Future<void> _loadInitialStatus() async {
    try {
      final job = await _firebaseService.getJobById(jobId);
      state = AsyncValue.data(job?.isActive ?? false);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> toggleStatus() async {
    try {
      final currentStatus = state.value ?? false;
      state = const AsyncValue.loading();
      await _firebaseService.updateJobStatus(jobId, !currentStatus);
      state = AsyncValue.data(!currentStatus);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }
final jobActivationProvider = Provider.family<Future<void> Function(), String>((ref, jobId) {
  final firebaseService = ref.read(firebaseServiceProvider);
  
  Future<void> toggleJob() async {
    try {
      final job = await firebaseService.getJobById(jobId);
      if (job != null) {
        await firebaseService.updateJobStatus(jobId, !job.isActive);
      }
    } catch (e) {
      throw Exception('Failed to toggle job status: $e');
    }
  }
  return toggleJob;
});
}