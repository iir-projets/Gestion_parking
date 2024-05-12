
import 'package:Web_flutter/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Admin/dashboard.dart';
import 'Admin/parkings.dart';
import 'Admin/superviseurs.dart';
import 'Authentication/screens/LoginScreen.dart';
import 'Superviseur/reservations.dart';
import 'Superviseur/spots.dart';
import 'controller/sidebar_controller.dart';




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
       initialRoute: '/login',
        getPages: [
          GetPage(name: '/login', page: () => LoginScreen()),
          GetPage(name: '/navscreen', page: () =>NavScreen(isAdmin: false)),
        ],
    );
  }
}
class NavScreen extends StatefulWidget {
  final bool isAdmin;

  const NavScreen({Key? key, required this.isAdmin}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],

      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Sidebar(isAdmin: widget.isAdmin),

          Expanded(
            child: Obx(() {
              final SidebarController sidebarController = Get.find();
              final int selectedIndex = sidebarController.index.value;
              return Pages.getPage(widget.isAdmin, selectedIndex);
            }),
          ),
        ],
      ),
    );
  }
}



class Pages {
  static Widget getPage(bool isAdmin, int selectedIndex) {
    if (isAdmin) {
      switch (selectedIndex) {
        case 0:
          return const Dashboard();
        case 1:
          return const ParkingPage();
        case 2:
          return const SuperviseurPage();
        default:
          return const Dashboard();
      }
    } else {
      switch (selectedIndex) {
        case 0:
          return const Dashboard();
        case 1:
          return const SpotsPage();
        case 2:
          return const ReservationPage();
        default:
          return const Dashboard();
      }
    }
  }
}

