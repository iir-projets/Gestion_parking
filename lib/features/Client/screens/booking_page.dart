
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../util/app_styles.dart';
import 'dart:math';

class BookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.primaryColor,
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
                const Row(
                  children: [
                    Text(
                      "Book Now ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
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
                      "Choose a spot ",
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: 'John Doe', // Replace with random value
                        decoration: InputDecoration(
                          fillColor: Styles.bgColor,
                          filled: true,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Styles.primaryColor,
                          ),
                          hintText: "ZYX Kumar",
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30),
                const Row(
                  children: [
                    Text(
                      "Enter Vehicle Number ",
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: 'WB 04 ED 0987', // Replace with random value
                        decoration: InputDecoration(
                          fillColor: Styles.bgColor,
                          filled: true,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.car_rental,
                            color: Styles.primaryColor,
                          ),
                          hintText: "WB 04 ED 0987",
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                const Row(
                  children: [
                    Text(
                      "Choose Slot Time (in Minutes)",
                    )
                  ],
                ),
                SizedBox(height: 10),
                Slider(
                  mouseCursor: MouseCursor.defer,
                  thumbColor: Styles.secondaryColor,
                  activeColor: Styles.secondaryColor,
                  inactiveColor: Styles.bgColor,
                  label: "${Random().nextInt(60)} min", // Replace with random value
                  value: Random().nextInt(60).toDouble(), // Replace with random value
                  onChanged: (v) {
                    // Do nothing
                  },
                  divisions: 5,
                  min: 10,
                  max: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("10"),
                      Text("20"),
                      Text("30"),
                      Text("40"),
                      Text("50"),
                      Text("60"),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Your Slot Name",
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Styles.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Slot Name",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                              Icons.currency_rupee,
                              size: 30,
                              color: Styles.primaryColor,
                            ),
                            Text(
                              "${Random().nextInt(200)}",
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


