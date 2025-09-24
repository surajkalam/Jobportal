// routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'Widget.dart';
class JobseekeerAppRouter {
  static final GoRouter router = GoRouter(
    routes:[
      GoRoute(
        path: '/',
        builder: (context, state) => JobseekerNavbar(),
      ),
  
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.error}'),
      ),
    ),
  );
}