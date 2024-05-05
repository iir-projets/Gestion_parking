
import 'package:flutter/material.dart';

import '../../../util/app_layout.dart';
import '../../../util/app_styles.dart';
class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.1, size.height, size.width * 0.3, size.height);
    path.lineTo(size.width * 0.7, size.height);
    path.quadraticBezierTo(size.width * 0.9, size.height, size.width, size.height * 0.7);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
class TicketScreen extends StatelessWidget {
  final String parkingName;
  final String selectedSlot;
  final int selectedTimeIndex;
  final int totalPrice;

  const TicketScreen({
    Key? key,
    required this.parkingName,
    required this.selectedSlot,
    required this.selectedTimeIndex,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Ticket'),
      ),
      body: Center(
        child: Container(
          width: size.width * 0.6,
          height: 350,
          decoration: BoxDecoration(
            color: Styles.secondaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipPath(
            clipper: TicketClipper(),
            child: Container(
              color: Styles.secondaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Parking Name: $parkingName',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Selected Slot: $selectedSlot',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Selected Time: ${selectedTimeIndex == 0 ? 'Not selected' : '$selectedTimeIndex hours'}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Total Price: $totalPrice ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
