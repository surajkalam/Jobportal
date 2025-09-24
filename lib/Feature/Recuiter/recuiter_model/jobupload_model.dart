import 'package:cloud_firestore/cloud_firestore.dart';
class JobModel {
  final String id;
  final String companyName;
  final String designation;
  final String ctc;
  final String noticePeriod;
  final String location;
  final String application;
  final String imageUrl;
  final String category;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String recruiterEmail;

  JobModel({
    this.id = '',
    required this.companyName,
    required this.designation,
    required this.ctc,
    required this.noticePeriod,
    required this.location,
    required this.application,
    required this.imageUrl,
    required this.category,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
    required this.recruiterEmail, 
  });

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'designation': designation,
      'ctc': ctc,
      'noticePeriod': noticePeriod,
      'location': location,
      'application': application,
      'imageUrl': imageUrl,
      'category': category,
      'isActive': isActive,
      'recruiterEmail': recruiterEmail,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory JobModel.fromMap(String id, Map<String, dynamic> map) {
    return JobModel(
      id: id,
      companyName: map['companyName'] ?? '',
      designation: map['designation'] ?? '',
      ctc: map['ctc'] ?? '',
      noticePeriod: map['noticePeriod'] ?? '',
      location: map['location'] ?? '',
      application: map['application'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      category: map['category'] ?? '',
      isActive: map['isActive'] ?? true,
      recruiterEmail: map['recruiterEmail'] ?? '', 
      createdAt: map['createdAt'] != null 
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null 
          ? (map['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  JobModel copyWith({
    String? id,
    String? companyName,
    String? designation,
    String? ctc,
    String? noticePeriod,
    String? location,
    String? application,
    String? imageUrl,
    String? category,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? recruiterEmail, 
  }) {
    return JobModel(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      designation: designation ?? this.designation,
      ctc: ctc ?? this.ctc,
      noticePeriod: noticePeriod ?? this.noticePeriod,
      location: location ?? this.location,
      application: application ?? this.application,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      recruiterEmail: recruiterEmail ?? this.recruiterEmail, 
    );
  }
}