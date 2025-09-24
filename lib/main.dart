import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:jobapp/Feature/Recuiter/Widget/go_route.dart';
import 'package:jobapp/core/material_theme.dart';
import 'package:jobapp/core/typography.dart';
import 'package:jobapp/firebase_options.dart';

import 'Feature/JobSeeker/widget/Widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  log('message: Firebase Initialized');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final materialTheme = MaterialTheme(textTheme);
    
    return ProviderScope( 
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: materialTheme.light(),
        darkTheme: materialTheme.dark(),
        themeMode: ThemeMode.system,
        routerConfig: JobseekeerAppRouter.router,
      ),
    );
  }
}