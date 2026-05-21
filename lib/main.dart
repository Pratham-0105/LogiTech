import 'package:flutter/material.dart';
import 'package:loditech/screens/dashboard.dart';
import 'package:loditech/screens/splash_screen.dart';
import 'screens/login_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'upload_service.dart'; // 👈 ADD THIS

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await uploadAllMockData(); // 👈 ADD THIS (runs once)

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}