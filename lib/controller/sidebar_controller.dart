import 'package:Web_flutter/Admin/dashboard.dart';
import 'package:Web_flutter/Admin/parkings.dart';
import 'package:Web_flutter/Admin/superviseurs.dart';
import 'package:get/get.dart';

class SidebarController extends GetxController
{
RxInt  index=1.obs;

var pages=[
  Dashboard(),
  ParkingPage(),
  SuperviseurPage(),
];
}