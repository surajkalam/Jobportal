// // jobseeker_provider.dart
// import 'dart:developer';
// import 'package:flutter_riverpod/legacy.dart';

// class JobseekerInfoState {
//   final String name;
//   final String email;
//   final String contact;
//   final String qualification;
//   final String jobDesignation;
//   final String location;
//   final String experience;
//   final String profileDescription;
//   final bool isLoading;
//   final String? error;

//   const JobseekerInfoState({
//     this.name = '',
//     this.email = '',
//     this.contact = '',
//     this.qualification = '',
//     this.jobDesignation = '',
//     this.location = '',
//     this.experience = '',
//     this.profileDescription = '',
//     this.isLoading = false,
//     this.error,
//   });

//   JobseekerInfoState copyWith({
//     String? name,
//     String? email,
//     String? contact,
//     String? qualification,
//     String? jobDesignation,
//     String? location,
//     String? experience,
//     String? profileDescription,
//     bool? isLoading,
//     String? error,
//   }) {
//     return JobseekerInfoState(
//       name: name ?? this.name,
//       email: email ?? this.email,
//       contact: contact ?? this.contact,
//       qualification: qualification ?? this.qualification,
//       jobDesignation: jobDesignation ?? this.jobDesignation,
//       location: location ?? this.location,
//       experience: experience ?? this.experience,
//       profileDescription: profileDescription ?? this.profileDescription,
//       isLoading: isLoading ?? this.isLoading,
//       error: error ?? this.error,
//     );
//   }
// }

// class JobseekerInfoNotifier extends StateNotifier<JobseekerInfoState> {
//   JobseekerInfoNotifier() : super(const JobseekerInfoState());

//   void setName(String value) {
//     state = state.copyWith(name: value);
//   }

//   void setEmail(String value) {
//     state = state.copyWith(email: value);
//   }

//   void setContact(String value) {
//     state = state.copyWith(contact: value);
//   }

//   void setQualification(String value) {
//     state = state.copyWith(qualification: value);
//   }

//   void setJobDesignation(String value) {
//     state = state.copyWith(jobDesignation: value);
//   }

//   void setLocation(String value) {
//     state = state.copyWith(location: value);
//   }

//   void setExperience(String value) {
//     state = state.copyWith(experience: value);
//   }

//   void setProfileDescription(String value) {
//     state = state.copyWith(profileDescription: value);
//   }

//   void setLoading(bool loading) {
//     state = state.copyWith(isLoading: loading);
//   }

//   void setError(String? error) {
//     state = state.copyWith(error: error);
//   }

//   void clearError() {
//     state = state.copyWith(error: null);
//   }

//   Future<void> submitInfo() async {
//     if (!_validateForm()) {
//       setError('Please fill all required fields correctly.');
//       return;
//     }

//     try {
//       setLoading(true);
//       setError(null);

//       // Simulate API call or save to database
//       await Future.delayed(const Duration(seconds: 2));

//       // Log the data (you can replace this with actual API call)
//       _logFormData();

//       setLoading(false);
      
//     } catch (e) {
//       setLoading(false);
//       setError('Failed to submit information: $e');
//     }
//   }

//   bool _validateForm() {
//     return state.name.isNotEmpty &&
//         state.email.isNotEmpty &&
//         state.contact.isNotEmpty &&
//         state.qualification.isNotEmpty &&
//         state.jobDesignation.isNotEmpty &&
//         state.location.isNotEmpty;
//   }

//   void _logFormData() {
//     // This is where you would typically save to database or call API
//     log('Jobseeker Info Submitted: ------------------------');
//     log('Name: ${state.name}');
//     log('Email: ${state.email}');
//     log('Contact: ${state.contact}');
//     log('Qualification: ${state.qualification}');
//     log('Job Designation: ${state.jobDesignation}');
//     log('Location: ${state.location}');
//     log('Experience: ${state.experience}');
//     log('Profile Description: ${state.profileDescription}');
//   }

//   void clearForm() {
//     state = const JobseekerInfoState();
//   }
// }

// final jobseekerInfoProvider = StateNotifierProvider<JobseekerInfoNotifier, JobseekerInfoState>(
//   (ref) => JobseekerInfoNotifier(),
// );