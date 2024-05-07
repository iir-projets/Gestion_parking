import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/sidebar_controller.dart';

class SidebarSuperviseur extends StatelessWidget {
  const SidebarSuperviseur({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SidebarController sidebarController = Get.find();
    final drawerTextColor = TextStyle(color: Colors.grey[600]);

    final tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);

    // Determine user type based on your logic
    final bool isAdmin = true; // Example: Assuming the user is admin

    return Drawer(
      backgroundColor: Colors.grey[300],
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
                  'R E S E R V A T I O N S',
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
              onTap: () => sidebarController.index.value = 3,
              selected: sidebarController.index.value == 3,
            ),
          ),
        ],
      )),
    );
  }
}
