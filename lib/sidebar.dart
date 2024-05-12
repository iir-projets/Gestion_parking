// sidebar.dart
import 'package:flutter/material.dart';
import 'Admin/sidebar_admin.dart';
import 'Superviseur/sidebar_sup.dart';

class Sidebar extends StatelessWidget {
  final bool isAdmin;

  const Sidebar({Key? key, required this.isAdmin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isAdmin ? SidebarAdmin() : SidebarSuperviseur();
  }
}
