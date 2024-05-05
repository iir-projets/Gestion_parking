import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:login_signup/features/Client/screens/booking_page.dart';

import '../../../util/app_info_list.dart';
import '../../../util/app_styles.dart';



class ParkingCarousel extends StatefulWidget {

  const ParkingCarousel({Key? key});

  @override
  _ParkingCarouselState createState() => _ParkingCarouselState();
}

class _ParkingCarouselState extends State<ParkingCarousel> {
  int currentIndex = 0;

  void _next() {
    setState(() {
      if (currentIndex < parkingList.length - 1) {
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
      body: _buildCarousel(),
    );
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
                    image: AssetImage("Assets/images/${parkingList[currentIndex]['image']}"),
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
                            children: _buildIndicator(),
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
                              parkingList[currentIndex]['place'],
                              style: TextStyle(
                                color: Styles.primaryColor,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                         const Gap(10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[

                              FadeInUp(
                                duration: Duration(milliseconds: 1400),
                                child: Text(
                                  '${parkingList[currentIndex]['destination']}',
                                  style: Styles.headLineStyle2
                                ),
                              ),
                              const Gap(10),
                              FadeInUp(
                                duration: Duration(milliseconds: 1400),
                                child: Text(
                                  '\$${parkingList[currentIndex]['price']}/hour',
                                  style: TextStyle(
                                    color: Colors.yellow[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                      const Gap(10),
                      FadeInUp(
                        duration: Duration(milliseconds: 1700),
                        child:
                        Center ( child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BookingPage(parkingId: parkingList[currentIndex]['id'])),

                            );
                          },
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

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < parkingList.length; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}

