import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ParkingListPage extends StatefulWidget {
  const ParkingListPage({Key? key}) : super(key: key);

  @override
  _ParkingListPageState createState() => _ParkingListPageState();
}

class _ParkingListPageState extends State<ParkingListPage> {
  List<dynamic> parkings = [];

  @override
  void initState() {
    super.initState();
    fetchParking(); // Fetch data when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Parking'),
      ),
      body:
       SingleChildScrollView(
          child: DataTable(
            columns: [
              DataColumn(label: Text('Parking ID')),
              DataColumn(label: Text('Parking Name')),
              DataColumn(label: Text('Address')),
              DataColumn(label: Text('Supervisor')),
            ],
            rows: parkings.map<DataRow>((parking) {
              final supervisor = parking['superviseur'] ?? {};
              return DataRow(
                cells: [
                  DataCell(Text('${parking['id_pk']}')),
                  DataCell(Text('${parking['nom_pk']}')),
                  DataCell(Text('${parking['adresse_pk']}')),
                  DataCell(
                    FutureBuilder<Map<String, dynamic>>(
                      future: fetchSupervisorInfo(supervisor['id_sup']),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text('Loading...');
                        } else if (snapshot.hasError) {
                          return Text('Error');
                        } else {
                          final supervisorInfo = snapshot.data!;
                          return Text('${supervisorInfo['nom_sup']} ${supervisorInfo['prenom_sup']}');
                        }
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),

    );
  }

  void fetchParking() async {
    print("fetch started");
    final url = 'http://localhost:8080/parkings';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      print('Response Data: $json'); // Print the response data for inspection

      // Assign the response data directly to the 'parkings' list
      setState(() {
        parkings = json; // Assign the response data directly
      });

      // Fetch supervisor info for each parking
      for (final parking in parkings) {
        final supervisorId = parking['superviseur']['id_sup'];
        final supervisorInfo = await fetchSupervisorInfo(supervisorId);
        // Update the 'parkings' list with supervisor info
        setState(() {
          parking['superviseur'] = supervisorInfo;
        });
      }
    } catch (e) {
      print('Error fetching data: $e'); // Print any error that occurs during fetching
    }

    print("fetch Completed");
  }

  Future<Map<String, dynamic>> fetchSupervisorInfo(int supervisorId) async {
    final url = 'http://localhost:8080/superviseur/$supervisorId';
    final uri = Uri.parse(url);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load supervisor information');
    }
  }
}
