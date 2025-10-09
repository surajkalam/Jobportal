// jobseeker_firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobapp/Feature/JobSeeker/modelclass/jobseeker_info.dart';
class JobseekerFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save jobseeker information
  Future<void> saveJobseekerInfo(JobseekerModel jobseeker, String email) async {
    try {
      await _firestore
          .collection('jobseekers')
          .doc(email) // Use email as document ID
          .set(jobseeker.toMap());
    } catch (e) {
      throw Exception('Failed to save jobseeker info: $e');
    }
  }

  // Get jobseeker information by email
  Future<JobseekerModel?> getJobseekerInfo(String email) async {
    try {
      final doc = await _firestore.collection('jobseekers').doc(email).get();
      if (doc.exists) {
        return JobseekerModel.fromMap(doc.id, doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get jobseeker info: $e');
    }
  }

  // Update jobseeker information
  Future<void> updateJobseekerInfo(JobseekerModel jobseeker, String email) async {
    try {
      await _firestore
          .collection('jobseekers')
          .doc(email)
          .update(jobseeker.toMap());
    } catch (e) {
      throw Exception('Failed to update jobseeker info: $e');
    }
  }

  // Check if jobseeker info exists
  Future<bool> jobseekerInfoExists(String email) async {
    try {
      final doc = await _firestore.collection('jobseekers').doc(email).get();
      return doc.exists;
    } catch (e) {
      throw Exception('Failed to check jobseeker info: $e');
    }
  }

  Future<void> saveJobseekerInfoWithResume(
  JobseekerModel jobseeker,
  String email,
  String resumeUrl,
  String resumeFileName,
) async {
  try {
    final jobseekerWithResume = jobseeker.copyWith(
      resumeUrl: resumeUrl,
      resumeFileName: resumeFileName,
    );
    
    await _firestore
        .collection('jobseekers')
        .doc(email)
        .set(jobseekerWithResume.toMap());
  } catch (e) {
    throw Exception('Failed to save jobseeker info with resume: $e');
  }
}
}