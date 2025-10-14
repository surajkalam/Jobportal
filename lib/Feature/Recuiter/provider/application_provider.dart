// // providers/application_provider.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/legacy.dart';
// import 'package:jobapp/Feature/Recuiter/provider/jobupload_provider.dart';
// import 'package:jobapp/Feature/Recuiter/recuiter_model/application_model.dart';
// // Status filter provider
// final applicationStatusProvider = StateProvider<String>((ref) => 'All');

// // Main applications provider that fetches all applications
// // final applicationsProvider = StreamProvider.autoDispose.family<List<ApplicationModel>, String>((ref, recruiterEmail) {
// //   final firebaseService = ref.watch(firebaseServiceProvider);
// //   return firebaseService.getAllApplicationsForRecruiter(recruiterEmail);
// // });

// // Filtered applications provider based on status
// // final filteredApplicationsProvider = Provider.autoDispose.family<List<ApplicationModel>, String>((ref, recruiterEmail) {
// //   final applicationsAsync = ref.watch(applicationsProvider(recruiterEmail));
// //   final selectedStatus = ref.watch(applicationStatusProvider);
  
// //   return applicationsAsync.when(
// //     data: (applications) {
// //       if (selectedStatus == 'All') return applications;
// //       return applications.where((app) => app.status == selectedStatus.toLowerCase()).toList();
// //     },
// //     loading: () => [],
// //     error: (error, stack) => [],
// //   );
// // });

// // Statistics providers
// // final totalApplicationsProvider = Provider.autoDispose.family<int, String>((ref, recruiterEmail) {
// //   final applicationsAsync = ref.watch(applicationsProvider(recruiterEmail));
// //   return applicationsAsync.when(
// //     data: (applications) => applications.length,
// //     loading: () => 0,
// //     error: (error, stack) => 0,
// //   );
// // });

// // final pendingApplicationsProvider = Provider.autoDispose.family<int, String>((ref, recruiterEmail) {
// //   final applicationsAsync = ref.watch(applicationsProvider(recruiterEmail));
// //   return applicationsAsync.when(
// //     data: (applications) => applications.where((app) => app.status == 'pending').length,
// //     loading: () => 0,
// //     error: (error, stack) => 0,
// //   );
// // });

// // final shortlistedApplicationsProvider = Provider.autoDispose.family<int, String>((ref, recruiterEmail) {
// //   final applicationsAsync = ref.watch(applicationsProvider(recruiterEmail));
// //   return applicationsAsync.when(
// //     data: (applications) => applications.where((app) => app.status == 'shortlisted').length,
// //     loading: () => 0,
// //     error: (error, stack) => 0,
// //   );
// // });

// // final rejectedApplicationsProvider = Provider.autoDispose.family<int, String>((ref, recruiterEmail) {
// //   final applicationsAsync = ref.watch(applicationsProvider(recruiterEmail));
// //   return applicationsAsync.when(
// //     data: (applications) => applications.where((app) => app.status == 'rejected').length,
// //     loading: () => 0,
// //     error: (error, stack) => 0,
// //   );
// // });
// final applicationsProvider = StreamProvider.autoDispose.family<List<ApplicationModel>, ({String recruiterEmail, String? jobId})>((ref, args) {
//   final firebaseService = ref.watch(firebaseServiceProvider);
//   if (args.jobId != null) {
//     return firebaseService.getApplicationsForJob(args.recruiterEmail, args.jobId!);
//   } else {
//     return firebaseService.getAllApplicationsForRecruiter(args.recruiterEmail);
//   }
// });
// // Filtered applications provider
// final filteredApplicationsProvider = Provider.autoDispose.family<List<ApplicationModel>, ({String recruiterEmail, String? jobId})>((ref, args) {
//   final applicationsAsync = ref.watch(applicationsProvider(args));
//   final selectedStatus = ref.watch(applicationStatusProvider);
  
//   return applicationsAsync.when(
//     data: (applications) {
//       if (selectedStatus == 'All') return applications;
//       return applications.where((app) => app.status == selectedStatus.toLowerCase()).toList();
//     },
//     loading: () => [],
//     error: (error, stack) => [],
//   );
// });
// // Update statistics providers to accept jobId
// final totalApplicationsProvider = Provider.autoDispose.family<int, String, {String? jobId}>((ref, recruiterEmail, {jobId}) {
//   final applicationsAsync = ref.watch(applicationsProvider((recruiterEmail: recruiterEmail, jobId: jobId)));
//   return applicationsAsync.when(
//     data: (applications) => applications.length,
//     loading: () => 0,
//     error: (error, stack) => 0,
//   );
// });

// final pendingApplicationsProvider = Provider.autoDispose.family<int, String, {String? jobId}>((ref, recruiterEmail, {jobId}) {
//   final applicationsAsync = ref.watch(applicationsProvider((recruiterEmail: recruiterEmail, jobId: jobId)));
//   return applicationsAsync.when(
//     data: (applications) => applications.where((app) => app.status == 'pending').length,
//     loading: () => 0,
//     error: (error, stack) => 0,
//   );
// });

// final shortlistedApplicationsProvider = Provider.autoDispose.family<int, String, {String? jobId}>((ref, recruiterEmail, {jobId}) {
//   final applicationsAsync = ref.watch(applicationsProvider((recruiterEmail: recruiterEmail, jobId: jobId)));
//   return applicationsAsync.when(
//     data: (applications) => applications.where((app) => app.status == 'shortlisted').length,
//     loading: () => 0,
//     error: (error, stack) => 0,
//   );
// });

// final rejectedApplicationsProvider = Provider.autoDispose.family<int, String, {String? jobId}>((ref, recruiterEmail, {jobId}) {
//   final applicationsAsync = ref.watch(applicationsProvider((recruiterEmail: recruiterEmail, jobId: jobId)));
//   return applicationsAsync.when(
//     data: (applications) => applications.where((app) => app.status == 'rejected').length,
//     loading: () => 0,
//     error: (error, stack) => 0,
//   );
// });

// // Application status update provider
// final applicationUpdateProvider = StateNotifierProvider<ApplicationUpdateNotifier, bool>((ref) {
//   return ApplicationUpdateNotifier();
// });

// class ApplicationUpdateNotifier extends StateNotifier<bool> {
//   ApplicationUpdateNotifier() : super(false);

//   Future<void> updateApplicationStatus({
//     required String recruiterEmail,
//     required String jobId,
//     required String applicationId,
//     required String newStatus,
//     required WidgetRef ref,
//   }) async {
//     state = true; // Start loading
//     try {
//       final firebaseService = ref.read(firebaseServiceProvider);
//       await firebaseService.updateApplicationStatus(
//         recruiterEmail: recruiterEmail,
//         jobId: jobId,
//         applicationId: applicationId,
//         newStatus: newStatus,
//       );
//       state = false; // Stop loading
//     } catch (e) {
//       state = false; // Stop loading
//       rethrow;
//     }
//   }

// }
// providers/application_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:jobapp/Feature/Recuiter/provider/jobupload_provider.dart';
import 'package:jobapp/Feature/combomodel/application_model.dart';

// Status filter provider
final applicationStatusProvider = StateProvider<String>((ref) => 'All');

// Create a data class for the provider arguments
class ApplicationsQueryParams {
  final String recruiterEmail;
  final String? jobId;

  ApplicationsQueryParams({required this.recruiterEmail, this.jobId});
}

// Main applications provider that fetches all applications or job-specific applications
final applicationsProvider = StreamProvider.autoDispose.family<List<ApplicationModel>, ApplicationsQueryParams>((ref, params) {
  final firebaseService = ref.watch(firebaseServiceProvider);
  if (params.jobId != null) {
    return firebaseService.getApplicationsForJob(params.recruiterEmail, params.jobId!);
  } else {
    return firebaseService.getAllApplicationsForRecruiter(params.recruiterEmail);
  }
});

// Filtered applications provider
final filteredApplicationsProvider = Provider.autoDispose.family<AsyncValue<List<ApplicationModel>>, ApplicationsQueryParams>((ref, params) {
  final applicationsAsync = ref.watch(applicationsProvider(params));
  final selectedStatus = ref.watch(applicationStatusProvider);

  return applicationsAsync.when(
    data: (applications) {
      if (selectedStatus == 'All') {
        return AsyncValue.data(applications);
      } else {
        final filteredApplications = applications.where((app) => app.status == selectedStatus.toLowerCase()).toList();
        return AsyncValue.data(filteredApplications);
      }
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});
// Statistics providers - simplified approach
final totalApplicationsProvider = Provider.autoDispose.family<int, ApplicationsQueryParams>((ref, params) {
  final applicationsAsync = ref.watch(applicationsProvider(params));
  return applicationsAsync.when(
    data: (applications) => applications.length,
    loading: () => 0,
    error: (error, stack) => 0,
  );
});

final pendingApplicationsProvider = Provider.autoDispose.family<int, ApplicationsQueryParams>((ref, params) {
  final applicationsAsync = ref.watch(applicationsProvider(params));
  return applicationsAsync.when(
    data: (applications) => applications.where((app) => app.status == 'pending').length,
    loading: () => 0,
    error: (error, stack) => 0,
  );
});

final shortlistedApplicationsProvider = Provider.autoDispose.family<int, ApplicationsQueryParams>((ref, params) {
  final applicationsAsync = ref.watch(applicationsProvider(params));
  return applicationsAsync.when(
    data: (applications) => applications.where((app) => app.status == 'shortlisted').length,
    loading: () => 0,
    error: (error, stack) => 0,
  );
});

final rejectedApplicationsProvider = Provider.autoDispose.family<int, ApplicationsQueryParams>((ref, params) {
  final applicationsAsync = ref.watch(applicationsProvider(params));
  return applicationsAsync.when(
    data: (applications) => applications.where((app) => app.status == 'rejected').length,
    loading: () => 0,
    error: (error, stack) => 0,
  );
});

// Application status update provider
final applicationUpdateProvider = StateNotifierProvider<ApplicationUpdateNotifier, bool>((ref) {
  return ApplicationUpdateNotifier();
});

class ApplicationUpdateNotifier extends StateNotifier<bool> {
  ApplicationUpdateNotifier() : super(false);

  Future<void> updateApplicationStatus({
    required String recruiterEmail,
    required String jobId,
    required String applicationId,
    required String newStatus,
    required WidgetRef ref,
  }) async {
    state = true; // Start loading
    try {
      final firebaseService = ref.read(firebaseServiceProvider);
      await firebaseService.updateApplicationStatus(
        recruiterEmail: recruiterEmail,
        jobId: jobId,
        applicationId: applicationId,
        newStatus: newStatus,
      );
      state = false; // Stop loading
    } catch (e) {
      state = false; // Stop loading
      rethrow;
    }
  }
}