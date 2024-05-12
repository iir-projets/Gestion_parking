
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../util/app_styles.dart';
import 'booking_page.dart';

class ParkingCarousel extends StatefulWidget {
  const ParkingCarousel({Key? key}) : super(key: key);

  @override
  _ParkingCarouselState createState() => _ParkingCarouselState();
}

class _ParkingCarouselState extends State<ParkingCarousel> {
  int currentIndex = 0;
  late List<dynamic> parkings;

  void _next() {
    setState(() {
      if (currentIndex < parkings.length - 1) {
        currentIndex++;
      } else {
        currentIndex = currentIndex;
      }
    });
  }

  void _preve() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      } else {
        currentIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: fetchParkingList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            parkings = snapshot.data!;
            return _buildCarousel();
          }
        },
      ),
    );
  }

  Future<List<dynamic>> fetchParkingList() async {
    final apiUrl = 'http://localhost:8080/parkings';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch parkings');
      }
    } catch (e) {
      throw Exception('Failed to fetch parkings: $e');
    }
  }

  Widget _buildCarousel() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.velocity.pixelsPerSecond.dx > 0) {
                _preve();
              } else if (details.velocity.pixelsPerSecond.dx < 0) {
                _next();
              }
            },
            child: FadeInUp(
              duration: Duration(milliseconds: 800),
              child: Container(
                width: double.infinity,
                height: 600,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("Assets/images/park1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.grey.shade700.withOpacity(.9),
                        Colors.grey.withOpacity(.0),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FadeInUp(
                        duration: Duration(milliseconds: 1000),
                        child: Container(
                          width: 90,
                          margin: EdgeInsets.only(bottom: 60),
                          child: Row(
                            children: _buildIndicator(parkings.length),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Transform.translate(
              offset: Offset(0, -40),
              child: FadeInUp(
                duration: Duration(milliseconds: 1000),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          FadeInUp(
                            duration: Duration(milliseconds: 1300),
                            child: Text(
                              parkings[currentIndex]['nom_pk'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${parkings[currentIndex]['adresse_pk']}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '\$${parkings[currentIndex]['price']}/hour',
                                style: TextStyle(
                                  color: Colors.yellow[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(

                        onTap: () {
                          print(parkings[currentIndex]['id_pk']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingPage(parkingId: parkings[currentIndex]['id_pk'],parkingName: parkings[currentIndex]['nom_pk'],parkingPrice: parkings[currentIndex]['price']),
                            ),
                          );

                        },
                        child: Center(
                          child: Container(
                            height: 60,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: primaryGradient,
                            ),
                            child: Center(
                              child: Text(
                                'Book now',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return Expanded(
      child: Container(
        height: 4,
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isActive ? Colors.grey[800] : Colors.white,
        ),
      ),
    );
  }

  List<Widget> _buildIndicator(int length) {
    List<Widget> indicators = [];
    for (int i = 0; i < length; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}
