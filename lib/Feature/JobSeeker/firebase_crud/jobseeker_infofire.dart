// jobseeker_firebase_service.dart
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jobapp/Feature/JobSeeker/modelclass/jobseeker_info.dart';
class JobseekerFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseStorage _storage = FirebaseStorage.instance;

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
// resume upload to Firebase Storage
    Future<String> uploadResume(File resumeFile, String email) async {
    try {
      if (!await resumeFile.exists()) {
        throw Exception('Resume file does not exist');
      }

      // Check file size (max 5MB)
      final fileLength = await resumeFile.length();
      if (fileLength > 5 * 1024 * 1024) {
        throw Exception('Resume file is too large. Maximum size is 5MB');
      }

      // Get file extension and validate
      final fileExtension = resumeFile.path.split('.').last.toLowerCase();
      if (!['pdf', 'doc', 'docx', 'word'].contains(fileExtension)) {
        throw Exception('Invalid file type. Only PDF, DOC, DOCX files are allowed');
      }

      String fileName = 'resume_${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
      Reference storageRef = _storage.ref().child('resumes/$email/$fileName');
      
      final metadata = SettableMetadata(
        contentType: _getMimeType(fileExtension),
        customMetadata: {'uploaded-by': email},
      );

      UploadTask uploadTask = storageRef.putFile(resumeFile, metadata);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload resume: $e');
    }
  }

  // Delete resume from Firebase Storage and update Firestore
  Future<void> deleteResume(String email) async {
    try {
      final jobseekerInfo = await getJobseekerInfo(email);
      if (jobseekerInfo == null || jobseekerInfo.resumeUrl.isEmpty) {
        throw Exception('No resume found to delete');
      }

      // Delete from Firebase Storage
      final resumeUrl = jobseekerInfo.resumeUrl;
      final ref = _storage.refFromURL(resumeUrl);
      await ref.delete();

      // Update Firestore to remove resume info
      await _firestore.collection('jobseekers').doc(email).update({
        'resumeUrl': '',
        'resumeFileName': '',
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to delete resume: $e');
    }
  }

  // Update resume info in Firestore
  Future<void> updateResumeInfo(
    String email,
    String resumeUrl,
    String resumeFileName
  ) async {
    try {
      await _firestore.collection('jobseekers').doc(email).update({
        'resumeUrl': resumeUrl,
        'resumeFileName': resumeFileName,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update resume info: $e');
    }
  }

  // Helper method to get MIME type
  String _getMimeType(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      default:
        return 'application/octet-stream';
    }
  }
}