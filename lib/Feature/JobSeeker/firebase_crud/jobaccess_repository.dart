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

  Stream<List<JobModel>> getJobsByLocation(String location) {
    return _firestore
        .collection('jobs')
        .where('isActive', isEqualTo: true)
        .where('location', isEqualTo: location)
        // .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => JobModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  // Fetch jobs by designation (job title)
  Stream<List<JobModel>> getJobsByDesignation(String designation) {
    return _firestore
        .collection('jobs')
        .where('isActive', isEqualTo: true)
        .where('designation', isEqualTo: designation)
        // .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => JobModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  // Fetch jobs by company name
  Stream<List<JobModel>> getJobsByCompanyName(String companyName) {
    return _firestore
        .collection('jobs')
        .where('isActive', isEqualTo: true)
        .where('companyName', isEqualTo: companyName)
        // .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => JobModel.fromMap(doc.id, doc.data()))
            .toList());
  }

  // Search jobs by multiple criteria (optional - for advanced search)
  Stream<List<JobModel>> searchJobs({required String query}) {
  if (query.isEmpty) {
    return getActiveJobs();
  }

  final searchTerm = query.toLowerCase();
  
  return _firestore
      .collection('jobs')
      .where('isActive', isEqualTo: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => JobModel.fromMap(doc.id, doc.data()))
          .where((job) =>
            job.companyName.toLowerCase().contains(searchTerm) ||
            job.designation.toLowerCase().contains(searchTerm) ||
            job.location.toLowerCase().contains(searchTerm) ||
            job.category.toLowerCase().contains(searchTerm) ||
            (job.skills?.toLowerCase().contains(searchTerm) ?? false) ||
            (job.qualifications?.toLowerCase().contains(searchTerm) ?? false))
          .toList());
}
  // Fetch all locations available
  Stream<List<String>> getAvailableLocations() {
    return _firestore
        .collection('jobs')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc.data()['location'] as String)
            .toSet() // Remove duplicates
            .toList());
  }

  // Fetch all designations available
  Stream<List<String>> getAvailableDesignations() {
    return _firestore
        .collection('jobs')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc.data()['designation'] as String)
            .toSet() // Remove duplicates
            .toList());
  }

  // Fetch all company names available
  Stream<List<String>> getAvailableCompanyNames() {
    return _firestore
        .collection('jobs')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc.data()['companyName'] as String)
            .toSet() // Remove duplicates
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