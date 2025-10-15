// import 'dart:developer';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:jobapp/Authentication/auth_state.dart';
// import 'package:jobapp/Authentication/user_provider.dart';
// import 'package:jobapp/Feature/combomodel/combo_gorouter.dart';
// import 'package:jobapp/core/material_theme.dart';
// import 'package:jobapp/core/typography.dart';
// import 'package:jobapp/firebase_options.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   log('message: Firebase Initialized');
//   runApp(const MainApp());
// }

// class MainApp extends ConsumerWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//      ref.watch(authListenerProvider);
    
//     final authState = ref.watch(authStateProvider);
    
//     // You can add automatic navigation here if user is already logged in
//     if (authState.isLoggedIn) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         // Navigate to appropriate screen based on user type
//         // You might want to store user type preference in shared preferences
//       });
//     }
//     final materialTheme = MaterialTheme(textTheme);
//     return ProviderScope(
//       child: MaterialApp.router(
//         debugShowCheckedModeBanner: false,
//         theme: materialTheme.light(),
//         darkTheme: materialTheme.dark(),
//         themeMode: ThemeMode.system,
//         routerConfig: JobPortalAppRouter.router,
//         // routerConfig: AppRouter.router,
//       ),
//     );
//   }
// }
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobapp/Authentication/auth_state.dart';
import 'package:jobapp/Authentication/user_provider.dart';
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
  runApp(const ProviderScope(child: MainApp())); // Wrap MainApp with ProviderScope
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Add the auth listener
    ref.watch(authListenerProvider);
    
    final authState = ref.watch(authStateProvider);
    
    // You can add automatic navigation here if user is already logged in
    if (authState.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Navigate to appropriate screen based on user type
        // You might want to store user type preference in shared preferences
      });
    }
    
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