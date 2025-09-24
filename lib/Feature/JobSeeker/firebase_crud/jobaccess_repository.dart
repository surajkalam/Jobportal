import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobapp/Feature/Recuiter/recuiter_model/jobupload_model.dart';

class JobRepository {
  final FirebaseFirestore _firestore;

  JobRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Fetch all active jobs
  Stream<List<JobModel>> getActiveJobs() {
    return _firestore
        .collection('jobs')
        .where('isActive', isEqualTo: true)
        // .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => JobModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  // Fetch jobs by category
  Stream<List<JobModel>> getJobsByCategory(String category) {
    return _firestore
        .collection('jobs')
        .where('isActive', isEqualTo: true)
        .where('category', isEqualTo: category)
        // .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => JobModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  // Fetch all categories available
  Stream<List<String>> getAvailableCategories() {
    return _firestore
        .collection('jobs')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc.data()['category'] as String)
            .toSet() // Remove duplicates
            .toList());
  }
}