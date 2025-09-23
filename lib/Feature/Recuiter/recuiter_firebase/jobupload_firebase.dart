// services/firebase_service.dart
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:jobapp/Feature/Recuiter/recuiter_model/jobupload_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

   Future<String> uploadImage(File imageFile) async {
    try {
      // Validate that the file exists and is accessible
      if (!await imageFile.exists()) {
        throw Exception('Image file does not exist or is inaccessible');
      }

      // Check file size (optional but recommended)
      final fileLength = await imageFile.length();
      if (fileLength > 10 * 1024 * 1024) { // 10MB limit
        throw Exception('Image file is too large. Maximum size is 10MB');
      }

      String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageRef = _storage.ref().child('company_images/$fileName');
      
      // Add metadata for better handling
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': imageFile.path},
      );

      UploadTask uploadTask = storageRef.putFile(imageFile, metadata);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Image upload failed: $e');
    }
  }

  Future<void> saveJobData(JobModel jobData) async {
    try {
      await _firestore.collection('jobs').add({
        'companyName': jobData.companyName,
        'designation': jobData.designation,
        'ctc': jobData.ctc,
        'noticePeriod': jobData.noticePeriod,
        'location': jobData.location,
        'application': jobData.application,
        'imageUrl': jobData.imageUrl,
        'category': jobData.category,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to save job data: $e');
    }
  }

  Stream<List<JobModel>> getJobsByCategory(String category) {
    return _firestore
        .collection('jobs')
        .where('category', isEqualTo: category)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => JobModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  Stream<List<JobModel>> getAllJobs() {
    return _firestore
        .collection('jobs')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => JobModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  // Toggle job status
  Future<void> updateJobStatus(String jobId, bool isActive) async {
    try {
      await _firestore.collection('jobs').doc(jobId).update({
        'isActive': isActive,
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      throw Exception('Failed to update job status: $e');
    }
  }
 
      // Get job by ID
   Future<JobModel?> getJobById(String jobId) async {
    try {
      final doc = await _firestore.collection('jobs').doc(jobId).get();
      if (doc.exists) {
        return JobModel.fromMap(doc.id, doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get job: $e');
    }
  }

    // Get active jobs only
  Stream<List<JobModel>> getActiveJobs() {
    return _firestore
        .collection('jobs')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => JobModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  // Get total jobs count
  Stream<int> getTotalJobsCount() {
    return _firestore.collection('jobs').snapshots().map((snapshot) => snapshot.docs.length);
  }

   // Get jobs by recruiter (if you need to filter by recruiter)
  Stream<List<JobModel>> getJobsByRecruiter(String recruiterEmail) {
    return _firestore
        .collection('jobs')
        .where('recruiterEmail', isEqualTo: recruiterEmail) // You might need to add this field
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => JobModel.fromMap(doc.id, doc.data()))
            .toList());
  }
}