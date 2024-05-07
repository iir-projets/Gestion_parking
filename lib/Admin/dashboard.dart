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
      final supervisorResponse = await http.get(Uri.parse('https://api.example.com/supervisors/count'));
      final parkingResponse = await http.get(Uri.parse('https://api.example.com/parkings/count'));

      if (supervisorResponse.statusCode == 200 && parkingResponse.statusCode == 200) {
        final supervisorData = jsonDecode(supervisorResponse.body);
        final parkingData = jsonDecode(parkingResponse.body);

        setState(() {
          supervisorCount = supervisorData['count'];
          parkingCount = parkingData['count'];
        });
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
              color: Colors.blue,
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
              color: Color(0xFF698CE1FF),
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
