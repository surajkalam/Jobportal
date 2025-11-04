// // // // services/firebase_service.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:jobapp/Feature/AdminSide/model/admin_issuereport.dart';

// import 'package:jobapp/Feature/JobSeeker/firebase_crud/jobaccess_repository.dart';
// // import 'package:jobapp/Feature/combomodel/jobupload_model.dart';

// class FirebaseService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final jobRepositoryProvider = Provider<JobRepository>((ref) => JobRepository());
// //  // Get all issues/reports for admin
// Stream<List<AdminIssuereport>> getAllIssuesReports() {
//   return _firestore
//       .collection('admin_issues_reports')
//       .orderBy('createdAt', descending: true)
//       .snapshots()
//       .map((snapshot) {
//     return snapshot.docs
//         .map((doc) => AdminIssuereport.fromMap(doc.id, doc.data()))
//         .toList();
//   });
// }

// // // Update issue/report status (for admin)
// Future<void> updateIssueStatus({
//   required String issueId,
//   required String status,
//   required String jobseekerEmail,
//   String? adminResponse,
// }) async {
//   try {
//     final updateData = {
//       'status': status,
//       'updatedAt': FieldValue.serverTimestamp(),
//       if (adminResponse != null) 'adminResponse': adminResponse,
//     };

//     // Update in admin collection
//     await _firestore
//         .collection('admin_issues_reports')
//         .doc(issueId)
//         .update(updateData);

//     // Also update in jobseeker's collection
//     await _firestore
//         .collection('jobseekers')
//         .doc(jobseekerEmail)
//         .collection('issues_reports')
//         .doc(issueId)
//         .update(updateData);

//   } catch (e) {
//     throw Exception('Failed to update issue status: $e');
//   }
// }
// }