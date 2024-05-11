import 'package:Web_flutter/Admin/parkings.dart';
import 'package:Web_flutter/Admin/superviseurs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Superviseur/spots.dart';
import 'controller/sidebar_controller.dart';
import 'Admin/dashboard.dart';
import 'Admin/sidebar_admin.dart';
import 'Superviseur/sidebar_sup.dart';



bool isAdmin = false;



void main() {
  Get.put(SidebarController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const MainScreen(),
    );
  }
}

// Change this based on the user type

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget sidebar;
    if (isAdmin) {
      sidebar = SidebarAdmin();
    } else {
      sidebar = SidebarSuperviseur();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Dashboard'), // Set the title of the AppBar
        centerTitle: false,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Render the sidebar based on user type
          sidebar,
          // Main Content
          Expanded(
            child: Obx(() {
              final SidebarController sidebarController = Get.find();
              final int selectedIndex = sidebarController.index.value;
              if (isAdmin) {
                // Render pages based on admin user type
                switch (selectedIndex) {
                  case 0:
                    return const Dashboard();
                  case 1:
                    return const ParkingPage();
                  case 2:
                    return const SuperviseurPage();
                  default:
                    return Container();
                }
              } else {
                // Render pages based on supervisor user type
                switch (selectedIndex) {
                  case 0:
                    return const Dashboard();
                  case 1:
                    return const SpotsPage();
                  case 2:
                    return const SuperviseurPage();
                // Add cases for supervisor-specific pages
                  default:
                    return Container();
                }
              }
            }),
          ),
        ],
      ),
    );
  }
}
