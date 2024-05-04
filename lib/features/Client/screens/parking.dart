import 'package:flutter/material.dart';
import 'package:login_signup/util/caroussel.dart';

import '../../../util/app_styles.dart';

class ParkingsScreen extends StatelessWidget {
  const ParkingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        children: [
          ParkingCarousel(),
        ],
      )
    );
  }
}
