import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:login_signup/features/Client/screens/parkingPage.dart';
import 'package:lottie/lottie.dart';
import 'dart:convert';
import '../../../util/app_layout.dart';
import '../../../util/app_styles.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> _futureParking;

  @override
  void initState() {
    super.initState();
    _futureParking = fetchParking();
  }

  Future<List<dynamic>> fetchParking() async {
    final apiUrl = 'http://localhost:8080/parkings'; // Replace with your API endpoint
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load parking');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good Morning",
                          style: Styles.headLineStyle3,
                        ),
                        Text(
                          "Book a Spot",
                          style: Styles.headLineStyle,
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage(
                            'Assets/images/Citing Carpark.png',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(25),
              ],
            ),
          ),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Lottie.asset(
              'Assets/animation/running_car.json',
              fit: BoxFit.cover,
            ),
          ),
          const Gap(15),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ParkingCarousel()),
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
          const Gap(20), // Add some spacing between the button and the "parkings section"
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Parkings ", style: Styles.headLineStyle2),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ParkingCarousel()),
                    );
                  },
                  child: Text("view all", style: Styles.headLineStyle4),
                ),
              ],
            ),
          ), // Parking
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20),
            child: FutureBuilder<List<dynamic>>(
              future: _futureParking,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final List<dynamic> parkings = snapshot.data!;
                  return Row(
                    children: parkings.map((parking) {
                      return Container(
                        width: size.width * 0.6,
                        height: 350,
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
                        margin: const EdgeInsets.only(right: 17, top: 5),
                        decoration: BoxDecoration(
                          color: Styles.secondaryColor,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Styles.primaryColor,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "Assets/images/park1.jpg",
                                  ),
                                ),
                              ),
                            ),
                            const Gap(15),
                            Text(
                              "${parking['nom_pk']}",
                              style: Styles.headLineStyle2.copyWith(color: Styles.primaryColor),
                            ),
                            const Gap(2),
                            Text(
                              "${parking['adresse_pk']}",
                              style: Styles.headLineStyle3.copyWith(color: Colors.white),
                            ),
                            const Gap(5),
                            Text(
                              '\$${parking['price']}/hour',
                              style: Styles.headLineStyle.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
          const Gap(15),
        ],
      ),
    );
  }
}
