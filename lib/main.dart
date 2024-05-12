import 'package:flutter/material.dart';

import 'package:login_signup/features/Authentication/screens/WelcomeScreen.dart';
import 'package:login_signup/features/Client/screens/bottom_bar.dart';
import 'package:login_signup/features/Client/screens/home_screen.dart';
import 'package:login_signup/util/app_styles.dart';
import 'package:login_signup/features/Client/screens/parkingPage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(

 primaryColor: primary,
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}


