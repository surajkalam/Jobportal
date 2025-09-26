// routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../Recuiter/recuiter_model/recuiter_model.dart';
import '../jobseekers_screens/jobseekers_screens.dart';
import 'Widget.dart';
class JobseekeerAppRouter {
  static final GoRouter router = GoRouter(
    routes:[
      GoRoute(
        path: '/',
        builder: (context, state) => JobseekerNavbar(),
      ),
       GoRoute(
        path: '/job-details',
         builder: (context, state) {
        final job = state.extra as JobModel;
        return JobDetailsScreen(job: job);
      },
      ),
  
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.error}'),
      ),
    ),
  );
}