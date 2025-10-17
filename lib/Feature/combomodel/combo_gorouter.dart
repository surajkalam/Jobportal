// routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jobapp/Authentication/Signupscreen.dart';
import 'package:jobapp/Authentication/auth_state.dart';
import 'package:jobapp/Authentication/checkloginsignup.dart';
import 'package:jobapp/Authentication/loginscreen.dart';
import 'package:jobapp/Authentication/provider.dart';
import 'package:jobapp/Feature/JobSeeker/widget/jobseeker_navbar.dart';
import 'package:jobapp/Feature/Recuiter/Widget/recuiternavbar.dart';
import 'package:jobapp/Feature/combomodel/jobupload_model.dart';

import '../../onboarding_screen/onboarding_screen.dart';
import '../JobSeeker/jobseekers_screens/jobseekers_screens.dart';
import '../Recuiter/screens/screens.dart';
class JobPortalAppRouter {
  static final GoRouter router = GoRouter(
    //     redirect: (context, state) {
    //   final container = ProviderScope.containerOf(context);
    //   final authState = container.read(authStateProvider);
    //   final userType = container.read(selectionProvider);

    //   // If user is not logged in and trying to access protected routes
    //   if (!authState.isLoggedIn && 
    //       (state.uri.toString().startsWith('/jobseeker') || 
    //        state.uri.toString().startsWith('/recruiter'))) {
    //     return '/login';
    //   }

    //   // If user is logged in, redirect based on user type
    //   if (authState.isLoggedIn) {
    //     // If user is on login/signup page, redirect to appropriate dashboard
    //     if (state.uri.toString() == '/login' || state.uri.toString() == '/signup') {
    //       return userType == UserType.jobseeker ? '/jobseeker-info' : '/recruiter-info';
    //     }

    //     // Ensure user accesses the correct dashboard based on their type
    //     if (userType == UserType.jobseeker && state.uri.toString().startsWith('/recruiter')) {
    //       return '/jobseeker-info';
    //     } else if (userType == UserType.recruiter && state.uri.toString().startsWith('/jobseeker')) {
    //       return '/recruiter-info';
    //     }
    //   }

    //   // No redirect needed
    //   return null;
    // },

    routes:[
      GoRoute(
        path: '/',
        builder: (context, state) =>OnboardingScreen1(),
      ),
       GoRoute(
        path: '/on-board2',
        builder: (context, state) =>OnboardingScreen2(),
      ),
      GoRoute(
        path: '/on-board3',
        builder: (context, state) =>OnboardingScreen3(),
      ),
      GoRoute(
        path: '/on-board4',
        builder: (context, state) =>OnboardingScreen4(),
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
        path: '/job-nav',
        builder: (context, state) => JobseekerNavbar(),
      ),
      GoRoute(
        path: '/jobseeker-info',
        builder: (context, state) => JobseekerInfo(),
      ),

      //Recuiter router

      GoRoute(
        path: '/recuiter-nav',
        builder: (context, state) => RecruiterNavbar(),
      ),
      GoRoute(
        path: '/job-details',
        builder: (context, state) {
          final job = state.extra as JobModel?;
          if(job == null){
            return Scaffold(
              body: Center(child: Text('No job data provided')),
            );
          }
          return JobDetailsScreen(job: job);
        },
      ),
      GoRoute(
        path: '/recuiter-info',
        builder: (context, state) => RecuiterInfo(),
      ),
      GoRoute(
        path: '/uploaddetail-job',
        builder: (context, state) {
          return JobuploaddetailScreen();
        },
      ),
      // GoRoute(
      //   path: '/application-detail',
      //   builder: (context, state) => ApplicationDetailScreen(),
      // ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.error}'))),
  );
}