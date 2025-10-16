import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobapp/Feature/combomodel/combo_gorouter.dart';
import 'package:jobapp/core/material_theme.dart';
import 'package:jobapp/core/typography.dart';
import 'package:jobapp/firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  log('message: Firebase Initialized');
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();
    // Check auth state after widget is mounted
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _checkAuthState();
    // });
  }

  // void _checkAuthState() {
  //   final authState = ref.read(authStateProvider);
    
  //   if (authState.isLoggedIn && authState.user != null) {
  //     final userEmail = authState.user!.email ?? '';
  //     final userType = ref.read(selectionProvider);
      
  //     // Store email in appropriate provider based on user type
  //     if (userType == UserType.jobseeker) {
  //       ref.read(currentUserProvider.notifier).state = userEmail;
  //       // Navigate to jobseeker screen
  //       context.go('/jobseeker-info');
  //     } else {
  //       ref.read(currentRecruiterUserEmailProvider.notifier).state = userEmail;
  //       // Navigate to recruiter screen
  //       context.go('/recruiter-info');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Add the auth listener
    // ref.watch(authListenerProvider);
    
    // final authState = ref.watch(authStateProvider);


    final materialTheme = MaterialTheme(textTheme);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: JobPortalAppRouter.router,
    );
  }
}