// recuiter_model/jobupload_model.dart
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
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'companyName': companyName,
      'designation': designation,
      'ctc': ctc,
      'noticePeriod': noticePeriod,
      'location': location,
      'application': application,
      'imageUrl': imageUrl,
      'category': category,
      'isActive': isActive, // Added this line
      'createdAt': createdAt.millisecondsSinceEpoch,
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
      isActive: map['isActive'] ?? true, // Added this line
      createdAt: map['createdAt'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : DateTime.now(),
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
    );
  }
}