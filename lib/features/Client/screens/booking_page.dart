import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:login_signup/features/Client/screens/ticket_screen.dart';
import 'package:login_signup/util/app_styles.dart';
import 'package:lottie/lottie.dart';

class BookingPage extends StatefulWidget {
  final int parkingId;
  final double parkingPrice;
  final String parkingName;

  const BookingPage({
    Key? key,
    required this.parkingId,
    required this.parkingName,
    required this.parkingPrice,
  }) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late Future<List<String>> futureSpots;
  int _selectedSlotIndex = 0;
  int _selectedTimeIndex = 0;
  List<String> _slots = [];


  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    futureSpots = fetchSpots(widget.parkingId);
  }

  Future<List<String>> fetchSpots(int parkingId) async {
    final response = await http.get(Uri.parse('http://localhost:8080/parking/$parkingId/places'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      // Filter spots where status is false
      final List<dynamic> filteredSpots = data.where((spot) => spot['statut_pl'] == false).toList();
      return filteredSpots.map((spot) => spot['num_pl'].toString()).toList();
    } else {
      throw Exception('Failed to load spots');
    }
  }



  double _calculateTotalPrice(int i) {
    return widget.parkingPrice * i;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Page'),
      ),
      body: FutureBuilder<List<String>>(
        future: futureSpots,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Parking: ${widget.parkingName}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      // Your color here
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          'Choose a spot',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField(
                      value: _selectedSlotIndex,
                      items: snapshot.data!.map((spot) => DropdownMenuItem(
                        value: snapshot.data!.indexOf(spot),
                        child: Text(spot),
                      )).toList(),
                      onChanged: (index) {
                        setState(() {
                          _selectedSlotIndex = index as int;
                        });
                      },
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Choose Slot Time (in Hours):',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField(
                      value: _selectedTimeIndex,
                      items: [
                        0,
                        1,
                        2,
                        4,
                        8,
                        24,
                      ]
                          .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value == 0 ? 'Not selected' : '$value h'),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedTimeIndex = value as int;
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
                                Text('Amount to Be Paid'),
                              ],
                            ),
                            Row(
                              children: [
                                // Your icon here
                                Text(
                                  '${_calculateTotalPrice(_selectedTimeIndex)}',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            if (_selectedTimeIndex != 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TicketScreen(
                                    parkingId: widget.parkingId,
                                    parkingName: widget.parkingName,
                                    selectedSlot: int.parse(snapshot.data![_selectedSlotIndex]),
                                    selectedTimeIndex: _selectedTimeIndex,
                                    totalPrice: _calculateTotalPrice(_selectedTimeIndex),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                            decoration: BoxDecoration(
                              gradient: primaryGradient,
                              // Your gradient here
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'PAY NOW',
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
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
