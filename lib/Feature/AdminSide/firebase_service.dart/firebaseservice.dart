// // services/firebase_service.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:jobapp/Feature/combomodel/jobupload_model.dart';

// class FirebaseService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Get all jobs for admin (from all recruiters)
//  Stream<List<JobModel>> getAllJobsForAdmin() {
//   return _firestore
//       .collection('jobs')
//       .snapshots()
//       .map((snapshot) {
//         return snapshot.docs.map((doc) {
//           // Create a new map and include the document ID
//           final Map<String, dynamic> data = {};
//           data.addAll(doc.data() as Map<String, dynamic>);
//           data['id'] = doc.id; // Include document ID
//           return JobModel.fromMap(data);
//         }).toList();
//       });
// }

//   // Add other job-related methods here...
// }