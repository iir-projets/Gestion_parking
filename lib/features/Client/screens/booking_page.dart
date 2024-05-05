
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../util/app_info_list.dart';
import '../../../util/app_styles.dart';
import 'dart:math';

class BookingPage extends StatefulWidget {
  final int parkingId;

  const BookingPage({Key? key, required this.parkingId}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}
String getParkingName(int parkingId) {
  // Search for the parking name based on the parking ID in the parkingList
  Map<String, dynamic>? parking = parkingList.firstWhere(
        (parking) => parking['id'] == parkingId,
    orElse: () => {'place': 'Unknown Parking'}, // Default value for unknown parking
  );

  // Return the name of the parking if found, otherwise return the default value
  return parking['place'];
}

class _BookingPageState extends State<BookingPage> {

  int _selectedSlotIndex = 0;
  int _selectedTimeIndex = 0;
  List<String> _slots = [];
  double _pricePerHour=20;

  @override
  void initState() {
    super.initState();
    _slots = getParkingSlots(widget.parkingId);
  }

  List<String> getParkingSlots(int parkingId) {
    // Retrieve the slots based on the parking ID from the parkingList
    Map<String, dynamic>? parking = parkingList.firstWhere(
          (parking) => parking['id'] == parkingId,
      orElse: () => {'slots': []}, // Default value for unknown parking
    );

    // Return the slots if found, otherwise return an empty list
    return List<String>.from(parking['slots']);
  }
  int getPricePerHour(int parkingId) {
    // Search for the parking in the parkingList based on the ID
    Map<String, dynamic>? parking = parkingList.firstWhere(
          (parking) => parking['id'] == parkingId,

    );

    // If the parking is found, return its price per hour
    // Otherwise, return a default value
    return  20; // Default price per hour
  }
  int _calculateTotalPrice(int i) {

    int pricePerHour = getPricePerHour(widget.parkingId);
    int totalPrice = pricePerHour * i;
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    String parkingName = getParkingName(widget.parkingId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.secondaryColor,
        title: const Text(
          "BOOK SLOT",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'Assets/animation/running_car.json',
                      width: 300,
                      height: 200,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                 Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Parking: $parkingName",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Styles.primaryColor,
                ),
                SizedBox(height: 30),
                const Row(
                  children: [
                    Text(
                      "Choose a spot ",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                DropdownButtonFormField(
                  value: _selectedSlotIndex,
                  items: _slots.map((slot) {
                    return DropdownMenuItem(
                      value: _slots.indexOf(slot),
                      child: Text(slot),
                    );
                  }).toList(),
                  onChanged: (index) {
                    setState(() {
                      _selectedSlotIndex = index!;


                      // Call a function to update the price based on the selected slot
                    });
                  },
                ),
                SizedBox(height: 50),


                const Text(
                  "Choose Slot Time (in Hours):",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField(
                  value: _selectedTimeIndex,
                  items: [
                    DropdownMenuItem(
                      value: 0,
                      child: Text("Not selected"),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text("1h"),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text("2h"),
                    ),
                    DropdownMenuItem(
                      value: 4,
                      child: Text("4h"),
                    ),
                    DropdownMenuItem(
                      value: 8,
                      child: Text("8h"),
                    ),
                    DropdownMenuItem(
                      value: 24,
                      child: Text("24h"),
                    ),
                  ],
                  onChanged: (index) {
                    setState(() {
                      _selectedTimeIndex = index!;

                    });
                  },
                ),


                SizedBox(height: 20),

                SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text("Amount to Be Paid"),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.currency_pound,
                              size: 30,
                              color: Styles.primaryColor,
                            ),
                            Text(
                              "${_calculateTotalPrice(_selectedTimeIndex)}",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                                color: Styles.primaryColor,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        // Perform action on tap
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                        decoration: BoxDecoration(
                          color: Styles.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "PAY NOW",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


