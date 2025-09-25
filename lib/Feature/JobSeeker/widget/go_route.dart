// routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobapp/Feature/JobSeeker/jobseekers_screens/jobseeker_home.dart';
import 'Widget.dart';
class JobseekeerAppRouter {
  static final GoRouter router = GoRouter(
    routes:[
      // GoRoute(
      //   path: '/',
      //   builder: (context, state) => JobseekerNavbar(),
      // ),
      GoRoute(
        path: '/',
        builder: (context, state) => JobSeekerDashboard(),
      ),
  
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.error}'),
      ),
    ),
  );
}