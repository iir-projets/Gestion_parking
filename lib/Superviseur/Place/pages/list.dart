import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SpotsListPage extends StatefulWidget {
  const SpotsListPage({Key? key}) : super(key: key);

  @override
  _SpotsListPageState createState() => _SpotsListPageState();
}

class _SpotsListPageState extends State<SpotsListPage> {
  List<dynamic> spots = [];
  int? parkingId;
  var supervisorId ; // Example supervisor ID
  String? parkingName;

  @override
  void initState() {
    super.initState();
    _initializePage();

  }
  Future<void> _initializePage() async {
    await fetchSupervisorID();
    if (supervisorId != null) {
      fetchSupervisorParking(supervisorId!); // Fetch supervisor parking with the fetched ID
    }
  }
  Future<void> fetchSupervisorID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      supervisorId = prefs.getInt('supervisorID');
    });
    if (supervisorId != null) {
      fetchSupervisorParking(supervisorId!); // Fetch supervisor parking with the fetched ID
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parking Spots'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Parking Name: $parkingName',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: spots.map<Widget>((spot) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.4, // Adjust width as needed
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Spot ID: ${spot['num_pl']}'),
                      Text('Status: ${spot['statut_pl']}'),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }



  Future<void> fetchSupervisorParking(int supervisorId) async {
    try {
      var url = Uri.parse('http://localhost:8080/superviseur/$supervisorId/parking');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data != null && data['nom_pk'] != null) {
          parkingName = data['nom_pk'];
          parkingId = data['id_pk'];

          setState(() {
            fetchSpotsForParking(parkingId); // Fetch spots for the obtained parkingId
          });
        } else {
          print('Invalid parking data for supervisor ID: $supervisorId');
        }
      } else {
        print('Failed to fetch parking: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching parking: $e');
    }
  }

  void fetchSpotsForParking(int? parkingId) async {
    if (parkingId == null) {
      print('Parking ID is null');
      return;
    }

    final url = 'http://localhost:8080/parking/$parkingId/places';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      setState(() {
        spots = json;
      });
    } catch (e) {
      print('Error fetching spots for parking: $e');
    }
  }
}
