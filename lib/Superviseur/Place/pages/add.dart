import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class SpotsAddPage extends StatefulWidget {
  const SpotsAddPage({Key? key}) : super(key: key);

  @override
  _SpotsAddPageState createState() => _SpotsAddPageState();
}

class _SpotsAddPageState extends State<SpotsAddPage> {
  final _formKey = GlobalKey<FormState>();
   var supervisorId ; // Ex
  String? parkingName;
  int? parkingId;
  int? placeId;
  String? addedPlaceInfo;

  @override
  void initState() {
    super.initState();
    _initializePage();
  }

  Future<void> _initializePage() async {
    await fetchSupervisorID();
    if (supervisorId != null) {
      fetchSupervisorParking(supervisorId!);
    }
  }

  Future<void> fetchSupervisorID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      supervisorId = prefs.getInt('supervisorID');
    });
    if (supervisorId != null) {
      fetchSupervisorParking(supervisorId!);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Spot'),
      ),
      body: Center(
        child: Container(
          width: 800,
          height: 800,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Add a Parking's Spot",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Parking Name: $parkingName',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),


                  if (addedPlaceInfo != null) ...[
                    SizedBox(height: 20),
                    Text(
                      'Added Place Info: $addedPlaceInfo',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submitForm();
                      }
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fetchSupervisorParking(int supervisorId) async {
    try {
      var url = Uri.parse(
          'http://localhost:8080/superviseur/$supervisorId/parking');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data != null && data['nom_pk'] != null) {

          parkingName = data['nom_pk'];
          parkingId = data['id_pk'];

          setState(() {});
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

  Future<void> assignParkingToPlace(int placeId, int parkingId) async {
    try {
      var assignParkingUrl = Uri.parse('http://localhost:8080/place/$placeId/parking/$parkingId');
      var response = await http.put(assignParkingUrl);

      if (response.statusCode == 200) {
        print('Place assigned to parking successfully');
      } else {
        print('Failed to assign place to parking: ${response.statusCode}');
      }
    } catch (e) {
      print('Error assigning parking to place: $e');
    }
  }

  void _submitForm() async {
    try {

      var placeData = {'statut_pl': false};


      var createPlaceUrl = Uri.parse('http://localhost:8080/place');
      var createPlaceResponse = await http.post(
        createPlaceUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(placeData),
      );

      if (createPlaceResponse.statusCode == 200) {

        print('Place created successfully');


        var responseData = jsonDecode(createPlaceResponse.body);
        var placeId = responseData['num_pl'];


        assignParkingToPlace(placeId, parkingId!);


        setState(() {
          addedPlaceInfo = 'Place ID: $placeId';
        });

      } else {

        print('Failed to create place: ${createPlaceResponse.statusCode}');
      }
    } catch (e) {

      print('Error submitting form: $e');
    }
  }
}
