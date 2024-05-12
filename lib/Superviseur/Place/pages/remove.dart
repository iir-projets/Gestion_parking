import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SpotsRemovePage extends StatefulWidget {
  const SpotsRemovePage({Key? key}) : super(key: key);

  @override
  _SpotsRemovePageState createState() => _SpotsRemovePageState();
}

class _SpotsRemovePageState extends State<SpotsRemovePage> {
  List<dynamic> spots = [];
  int? selectedSpotId;
  var supervisorId ; // Ex
  int? parkingId;
  int? placeId;
  
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
        title: Text('Remove Spot'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButton<int>(
              hint: Text('Select Spot'),
              value: selectedSpotId,
              onChanged: (int? value) {
                setState(() {
                  selectedSpotId = value;
                });
              },
              items: spots.map<DropdownMenuItem<int>>((spot) {
                return DropdownMenuItem<int>(
                  value: spot['num_pl'],
                  child: Text('Spot ID: ${spot['num_pl']}'),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedSpotId != null) {
                  deleteSpot(selectedSpotId!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select a spot to remove.'),
                    ),
                  );
                }
              },
              child: Text('Remove Spot'),
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
        if (data != null && data['id_pk'] != null) {
          parkingId = data['id_pk'];

          // Fetch places based on the obtained parking ID
          fetchPlacesForParking(parkingId!);
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

  Future<void> fetchPlacesForParking(int parkingId) async {
    try {
      var url = Uri.parse('http://localhost:8080/parking/$parkingId/places');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          spots = data;
        });
      } else {
        print('Failed to fetch places: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching places: $e');
    }
  }


  void deleteSpot(int spotId) async {
    final url = 'http://localhost:8080/place/$spotId';
    final uri = Uri.parse(url);

    try {
      final response = await http.delete(uri);
      if (response.statusCode == 200) {

        Navigator.of(context).pop();
      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete spot. Please try again.'),
          ),
        );
      }
    } catch (e) {
      print('Error deleting spot: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred while deleting the spot.'),
        ),
      );
    }
  }
}
