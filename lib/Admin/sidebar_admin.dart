import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/sidebar_controller.dart';

class SidebarAdmin extends StatelessWidget {
  const SidebarAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SidebarController sidebarController = Get.find();
    final drawerTextColor = TextStyle(color: Colors.white70);

    final tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);

    // Determine user type based on your logic
    final bool isAdmin = true; // Example: Assuming the user is admin

    return Drawer(
      backgroundColor: Color(0xFFa5a5e0),
      elevation: 0,
      child: Obx(() => Column(
        children: [
          const DrawerHeader(
            child: Icon(
              Icons.local_parking,
              size: 64,
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.home),
              title:  Text(
                'D A S H B O A R D',
                style: drawerTextColor,
              ),
              onTap: () => sidebarController.index.value = 0,
              selected: sidebarController.index.value == 0,
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.local_parking),
              title: Text(
                'P A R K I N G',
                style: drawerTextColor,
              ),
              onTap: () => sidebarController.index.value = 1,
              selected: sidebarController.index.value == 1,
            ),
          ),
          // Show Supervisor menu if admin, otherwise hide it
          if (isAdmin)
            Padding(
              padding: tilePadding,
              child: ListTile(
                leading: const Icon(Icons.person),
                title:  Text(
                  'S U P E R V I S E U R',
                  style: drawerTextColor,
                ),
                onTap: () => sidebarController.index.value = 2,
                selected: sidebarController.index.value == 2,
              ),
            ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: const Icon(Icons.logout),
              title:  Text(
                'L O G O U T',
                style: drawerTextColor,
              ),

            ),
          ),
        ],
      )),
    );
  }
}
