import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Web_flutter/controller/sidebar_controller.dart';

var defaultBackgroundColor = Colors.grey[300];
var appBarColor = Colors.grey[900];
var myAppBar = AppBar(
  backgroundColor: appBarColor,
  title: Text(' '),
  centerTitle: false,
);
var drawerTextColor = TextStyle(
  color: Colors.grey[600],
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);
SidebarController sidebarController = Get.put(SidebarController());
var myDrawer = Drawer(
  backgroundColor: Colors.grey[300],
  elevation: 0,
  child : Obx(() => Column(
    children: [
      DrawerHeader(
        child: Icon(
          Icons.favorite,
          size: 64,
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.home),
          title: Text(
            'D A S H B O A R D',
            style: drawerTextColor,
          ),
          onTap: ()=>sidebarController.index.value=0,
          selected: sidebarController.index.value==0,
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.local_parking),
          title: Text(
            'P A R K I N G',
            style: drawerTextColor,
          ),
          onTap: ()=>sidebarController.index.value=1,
          selected: sidebarController.index.value==1,
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.person),
          title: Text(
            'S U P E R V I S E U R',
            style: drawerTextColor,
          ),
          onTap: ()=>sidebarController.index.value=2,
          selected: sidebarController.index.value==2,
        ),
      ),
      Padding(
        padding: tilePadding,
        child: ListTile(
          leading: Icon(Icons.logout),
          title: Text(
            'L O G O U T',
            style: drawerTextColor,
          ),
          onTap: ()=>sidebarController.index.value=3,
          selected: sidebarController.index.value==3,
        ),
      ),
    ],
  )),

);
