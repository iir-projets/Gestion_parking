import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int? supervisorCount;
  int? parkingCount;

  @override
  void initState() {
    super.initState();
    fetchCounts();
  }

  Future<void> fetchCounts() async {
    try {
      final supervisorResponse = await http.get(Uri.parse('http://localhost:8080/superviseurs/count'));
      final parkingResponse = await http.get(Uri.parse('http://localhost:8080/parkings/count'));
      print('Supervisor response status code: ${supervisorResponse.statusCode}');
      print('Parking response status code: ${parkingResponse.statusCode}');
      if (supervisorResponse.statusCode == 200 && parkingResponse.statusCode == 200) {
        final supervisorCountString = supervisorResponse.body;
        final parkingCountString = parkingResponse.body;
        final supervisorCountInt = int.tryParse(supervisorCountString);
        final parkingCountInt = int.tryParse(parkingCountString);

        if (supervisorCountInt != null && parkingCountInt != null) {
          setState(() {
            supervisorCount = supervisorCountInt;
            parkingCount = parkingCountInt;
          });
        } else {
          throw Exception('Invalid count data');
        }
      } else {
        throw Exception('Failed to fetch counts');
      }
    } catch (e) {
      print('Error fetching counts: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              color: Color(0xFFa5a5e0),
              child: Center(
                child: Text(
                  supervisorCount != null ? '$supervisorCount' : '...',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Supervisors',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            Container(
              width: 150,
              height: 150,
              color: Colors.black,
              child: Center(
                child: Text(
                  parkingCount != null ? '$parkingCount' : '...',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Parkings Available',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
