import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jobapp/Authentication/checkloginsignup.dart';
import 'package:jobapp/core/material_theme.dart';
import 'package:jobapp/core/typography.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final materialTheme = MaterialTheme(textTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: ThemeMode.system,
      home: CheckLoginSignupScreen(),
    );
  }
}
