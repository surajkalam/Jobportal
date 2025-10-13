// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:jobapp/Feature/combomodel/jobupload_model.dart';

// class JobRepository {
//   final FirebaseFirestore _firestore;

//   JobRepository({FirebaseFirestore? firestore})
//       : _firestore = firestore ?? FirebaseFirestore.instance;

//   // Fetch all active jobs
//   Stream<List<JobModel>> getActiveJobs() {
//     return _firestore
//         .collection('jobs')
//         .where('isActive', isEqualTo: true)
//         // .orderBy('createdAt', descending: true)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => JobModel.fromMap(doc.id, doc.data()))
//             .toList());
//   }
//   // Fetch jobs by category
//   Stream<List<JobModel>> getJobsByCategory(String category) {
//     return _firestore
//         .collection('jobs')
//         .where('isActive', isEqualTo: true)
//         .where('category', isEqualTo: category)
//         // .orderBy('createdAt', descending: true)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => JobModel.fromMap(doc.id, doc.data()))
//             .toList());
//   }

//   Stream<List<JobModel>> getJobsByLocation(String location) {
//     return _firestore
//         .collection('jobs')
//         .where('isActive', isEqualTo: true)
//         .where('location', isEqualTo: location)
//         // .orderBy('createdAt', descending: true)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => JobModel.fromMap(doc.id, doc.data()))
//             .toList());
//   }

//   // Fetch jobs by designation (job title)
//   Stream<List<JobModel>> getJobsByDesignation(String designation) {
//     return _firestore
//         .collection('jobs')
//         .where('isActive', isEqualTo: true)
//         .where('designation', isEqualTo: designation)
//         // .orderBy('createdAt', descending: true)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => JobModel.fromMap(doc.id, doc.data()))
//             .toList());
//   }

//   // Fetch jobs by company name
//   Stream<List<JobModel>> getJobsByCompanyName(String companyName) {
//     return _firestore
//         .collection('jobs')
//         .where('isActive', isEqualTo: true)
//         .where('companyName', isEqualTo: companyName)
//         // .orderBy('createdAt', descending: true)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => JobModel.fromMap(doc.id, doc.data()))
//             .toList());
//   }

//   // Search jobs by multiple criteria (optional - for advanced search)
//   Stream<List<JobModel>> searchJobs({required String query}) {
//   if (query.isEmpty) {
//     return getActiveJobs();
//   }

//   final searchTerm = query.toLowerCase();

//   return _firestore
//       .collection('jobs')
//       .where('isActive', isEqualTo: true)
//       .snapshots()
//       .map((snapshot) => snapshot.docs
//           .map((doc) => JobModel.fromMap(doc.id, doc.data()))
//           .where((job) =>
//             job.companyName.toLowerCase().contains(searchTerm) ||
//             job.designation.toLowerCase().contains(searchTerm) ||
//             job.location.toLowerCase().contains(searchTerm) ||
//             job.category.toLowerCase().contains(searchTerm) ||
//             (job.skills?.toLowerCase().contains(searchTerm) ?? false) ||
//             (job.qualifications?.toLowerCase().contains(searchTerm) ?? false))
//           .toList());
// }
//   // Fetch all locations available
//   Stream<List<String>> getAvailableLocations() {
//     return _firestore
//         .collection('jobs')
//         .where('isActive', isEqualTo: true)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => doc.data()['location'] as String)
//             .toSet() // Remove duplicates
//             .toList());
//   }

//   // Fetch all designations available
//   Stream<List<String>> getAvailableDesignations() {
//     return _firestore
//         .collection('jobs')
//         .where('isActive', isEqualTo: true)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => doc.data()['designation'] as String)
//             .toSet() // Remove duplicates
//             .toList());
//   }

//   // Fetch all company names available
//   Stream<List<String>> getAvailableCompanyNames() {
//     return _firestore
//         .collection('jobs')
//         .where('isActive', isEqualTo: true)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => doc.data()['companyName'] as String)
//             .toSet() // Remove duplicates
//             .toList());
//   }

//   // Fetch all categories available
//   Stream<List<String>> getAvailableCategories() {
//     return _firestore
//         .collection('jobs')
//         .where('isActive', isEqualTo: true)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => doc.data()['category'] as String)
//             .toSet() // Remove duplicates
//             .toList());
//   }
// }


// Revised Implementation without collectionGroup . single file

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobapp/Feature/combomodel/jobupload_model.dart';

class JobRepository {
  final FirebaseFirestore _firestore;

  JobRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  // Fetch all active jobs from all recruiters
  Stream<List<JobModel>> getActiveJobs() {
    try {
      // Alternative approach: Get all recruiters first, then their jobs
      return _firestore.collection('recruiters').snapshots().asyncMap((
        recruitersSnapshot,
      ) async {
        final allJobs = <JobModel>[];

        for (final recruiterDoc in recruitersSnapshot.docs) {
          try {
            final jobsSnapshot = await _firestore
                .collection('recruiters')
                .doc(recruiterDoc.id)
                .collection('jobs')
                .where('isActive', isEqualTo: true)
                .get();
            allJobs.addAll(
              jobsSnapshot.docs
                  .map((doc) => JobModel.fromMap(doc.id, doc.data()))
                  .toList(),
            );
          } catch (e) {
            log('Error fetching jobs for recruiter ${recruiterDoc.id}: $e');
          }
        }

        return allJobs;
      });
    } catch (e) {
      log('Error in getActiveJobs: $e');
      // Fallback: Return empty list
      return Stream.value([]);
    }
  }
  Stream<List<JobModel>> getJobsByCategory(String category) {
    try {
      return _firestore.collection('recruiters').snapshots().asyncMap((
        recruitersSnapshot,
      ) async {
        final categoryJobs = <JobModel>[];
        for (final recruiterDoc in recruitersSnapshot.docs) {
          try {
            final jobsSnapshot = await _firestore
                .collection('recruiters')
                .doc(recruiterDoc.id)
                .collection('jobs')
                .where('isActive', isEqualTo: true)
                .where('category', isEqualTo: category)
                .get();
            categoryJobs.addAll(
              jobsSnapshot.docs
                  .map((doc) => JobModel.fromMap(doc.id, doc.data()))
                  .toList(),
            );
          } catch (e) {
            log(
              'Error fetching category jobs for recruiter ${recruiterDoc.id}: $e',
            );
          }
        }

        return categoryJobs;
      });
    } catch (e) {
      log('Error in getJobsByCategory: $e');
      return Stream.value([]);
    }
  }

  // Add similar temporary implementations for other methods...
  Stream<List<JobModel>> getJobsByLocation(String location) {
    try {
      return _firestore.collection('recruiters').snapshots().asyncMap((
        recruitersSnapshot,
      ) async {
        final locationJobs = <JobModel>[];

        for (final recruiterDoc in recruitersSnapshot.docs) {
          try {
            final jobsSnapshot = await _firestore
                .collection('recruiters')
                .doc(recruiterDoc.id)
                .collection('jobs')
                .where('isActive', isEqualTo: true)
                .where('location', isEqualTo: location)
                .get();

            locationJobs.addAll(
              jobsSnapshot.docs
                  .map((doc) => JobModel.fromMap(doc.id, doc.data()))
                  .toList(),
            );
          } catch (e) {
            log(
              'Error fetching location jobs for recruiter ${recruiterDoc.id}: $e',
            );
          }
        }

        return locationJobs;
      });
    } catch (e) {
      log('Error in getJobsByLocation: $e');
      return Stream.value([]);
    }
  }

  // Simple search without collectionGroup
  Stream<List<JobModel>> searchJobs({required String query}) {
    if (query.isEmpty) {
      return getActiveJobs();
    }

    final searchTerm = query.toLowerCase();

    return getActiveJobs().map(
      (jobs) => jobs
          .where(
            (job) =>
                job.companyName.toLowerCase().contains(searchTerm) ||
                job.designation.toLowerCase().contains(searchTerm) ||
                job.location.toLowerCase().contains(searchTerm) ||
                job.category.toLowerCase().contains(searchTerm) ||
                (job.skills.toLowerCase().contains(searchTerm) ?? false) ||
                (job.qualifications.toLowerCase().contains(searchTerm) ??
                    false),
          )
          .toList(),
    );
  }

  // Get available categories without collectionGroup
  Stream<List<String>> getAvailableCategories() {
    return getActiveJobs().map(
      (jobs) => jobs.map((job) => job.category).toSet().toList(),
    );
  }

  // Similar implementations for other getAvailable... methods
  Stream<List<String>> getAvailableLocations() {
    return getActiveJobs().map(
      (jobs) => jobs.map((job) => job.location).toSet().toList(),
    );
  }

  Stream<List<String>> getAvailableCompanyNames() {
    return getActiveJobs().map(
      (jobs) => jobs.map((job) => job.companyName).toSet().toList(),
    );
  }

  Stream<List<String>> getAvailableDesignations() {
    return getActiveJobs().map(
      (jobs) => jobs.map((job) => job.designation).toSet().toList(),
    );
  }
  // Get job by ID (need to know which recruiter it belongs to)
  Future<JobModel?> getJobById(String jobId, String recruiterEmail) async {
    try {
      final doc = await _firestore
          .collection('recruiters')
          .doc(recruiterEmail)
          .collection('jobs')
          .doc(jobId)
          .get();

      if (doc.exists) {
        return JobModel.fromMap(doc.id, doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get job: $e');
    }
  }

  // Apply for a job - creates application in both jobseeker and recruiter collections
  Future<void> applyForJob({
    required String jobseekerEmail,
    required String jobseekerName,
    required String jobId,
    required String recruiterEmail,
    required String jobTitle,
    required String resumeUrl,
    required String coverLetter,
  }) async {
    try {
      final applicationData = {
        'jobseekerEmail': jobseekerEmail,
        'jobseekerName': jobseekerName,
        'resumeUrl': resumeUrl,
        'coverLetter': coverLetter,
        'appliedAt': FieldValue.serverTimestamp(),
        'status': 'pending', // pending, reviewed, accepted, rejected
      };

      // Create application in jobseeker's applications subcollection
      await _firestore
          .collection('jobseekers')
          .doc(jobseekerEmail)
          .collection('applications')
          .add({
            'job_id': jobId,
            'recruiter_email': recruiterEmail,
            'job_title': jobTitle,
            'applied_at': FieldValue.serverTimestamp(),
            'status': 'pending',
          });

      // Create application in recruiter's job applications subcollection
      await _firestore
          .collection('recruiters')
          .doc(recruiterEmail)
          .collection('jobs')
          .doc(jobId)
          .collection('applications')
          .add(applicationData);
    } catch (e) {
      throw Exception('Failed to apply for job: $e');
    }
  }

  // Get jobseeker's applications
  Stream<List<Map<String, dynamic>>> getJobseekerApplications(
    String jobseekerEmail,
  ) {
    return _firestore
        .collection('jobseekers')
        .doc(jobseekerEmail)
        .collection('applications')
        .orderBy('applied_at', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => {'application_id': doc.id, ...doc.data()})
              .toList(),
        );
  }

  // Check if jobseeker has already applied for a job
  Future<bool> hasAppliedForJob(
    String jobseekerEmail,
    String jobId,
    String recruiterEmail,
  ) async {
    try {
      final query = await _firestore
          .collection('jobseekers')
          .doc(jobseekerEmail)
          .collection('applications')
          .where('job_id', isEqualTo: jobId)
          .where('recruiter_email', isEqualTo: recruiterEmail)
          .get();

      return query.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check application status: $e');
    }
  }
}
