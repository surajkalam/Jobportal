// routes/app_router.dart
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:jobapp/Authentication/Signupscreen.dart';
import 'package:jobapp/Authentication/checkloginsignup.dart';
import 'package:jobapp/Authentication/forgot_password_screen.dart';
import 'package:jobapp/Authentication/loginscreen.dart';
import 'package:jobapp/Feature/JobSeeker/widget/jobseeker_navbar.dart';
import 'package:jobapp/Feature/Recuiter/Widget/recuiternavbar.dart';
import 'package:jobapp/Feature/combomodel/jobupload_model.dart';
import 'package:jobapp/core/services/local_storage_service.dart';
import '../../onboarding_screen/onboarding_screen.dart';
import '../JobSeeker/jobseekers_screens/jobseekers_screens.dart';
import '../Recuiter/screens/screens.dart';

class JobPortalAppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final localStorage = LocalStorageService();
      final isLoggedIn = localStorage.isLoggedIn;
      final userType = localStorage.userType;
      final isOnboardingCompleted = localStorage.isOnboardingCompleted;
      final location = state.uri.path;

      // Define allowed routes for each user type
      final jobseekerAllowedRoutes = ['/job-nav', '/job-details', '/jobseeker-info', '/see-all-jobs'];
      final recruiterAllowedRoutes = ['/recuiter-nav', '/uploaddetail-job', '/job-details', '/see-all-jobs', '/recruiter-info'];

      if (isLoggedIn && userType != null) {
        if (userType == 'jobseeker' && !jobseekerAllowedRoutes.contains(location)) {
          return '/job-nav';
        } else if (userType == 'recruiter' && !recruiterAllowedRoutes.contains(location)) {
          return '/recuiter-nav';
        }
      }

      if (isOnboardingCompleted && location == '/') {
        return '/check-login';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => OnboardingScreen1()),
      GoRoute(
        path: '/on-board2',
        builder: (context, state) => OnboardingScreen2(),
      ),
      GoRoute(
        path: '/on-board3',
        builder: (context, state) => OnboardingScreen3(),
      ),
      GoRoute(
        path: '/on-board4',
        builder: (context, state) => OnboardingScreen4(),
      ),
      GoRoute(
        path: '/check-login',
        builder: (context, state) => CheckLoginSignupScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          final option = state.extra as String? ?? 'jobseeker';
          return LoginScreen(option: option);
        },
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) {
          final option = state.extra as String? ?? 'jobseeker';
          return SignupScreen(option: option);
        },
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(path: '/job-nav', builder: (context, state) => JobseekerNavbar()),

      //Recuiter router
      GoRoute(
        path: '/recuiter-nav',
        builder: (context, state) => RecruiterNavbar(),
      ),
      GoRoute(
        path: '/job-details',
        builder: (context, state) {
          final job = state.extra as JobModel?;
          if (job == null) {
            return Scaffold(body: Center(child: Text('No job data provided')));
          }
          return JobDetailsScreen(job: job);
        },
      ),
      GoRoute(
        path: '/uploaddetail-job',
        builder: (context, state) {
          return JobuploaddetailScreen();
        },
      ),
      GoRoute(
        path: '/see-all-jobs',
        builder: (context, state) => SeeAllJobsScreen(),
      ),
      GoRoute(
        path: '/jobseeker-info',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final email = extra?['email'] as String? ?? '';
          final phone = extra?['phone'] as String? ?? '';
          final password = extra?['password'] as String? ?? '';

          return JobseekerInfo(email: email, phone: phone, password: password);
        },
      ),
      GoRoute(
        path: '/recruiter-info',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final email = extra?['email'] as String? ?? '';
          final phone = extra?['phone'] as String? ?? '';
          final password = extra?['password'] as String? ?? '';

          return RecuiterInfo(email: email, phone: phone, password: password);
        },
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.error}'))),
  );
}
