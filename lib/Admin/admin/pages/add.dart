import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ParkingAddPage extends StatefulWidget {
  const ParkingAddPage({Key? key}) : super(key: key);

  @override
  _ParkingAddPageState createState() => _ParkingAddPageState();
}

class _ParkingAddPageState extends State<ParkingAddPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _parkingNameController = TextEditingController();
  TextEditingController _parkingAddressController = TextEditingController();
  TextEditingController _parkingPriceController = TextEditingController();

  List<Map<String, dynamic>> unassignedSupervisors = [];
  Map<String, dynamic>? selectedSupervisor;

  @override
  void initState() {
    super.initState();
    fetchUnassignedSupervisors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Parking'),
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
                    'Add Parking',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 30),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _parkingNameController,
                    decoration: InputDecoration(labelText: 'Parking Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter parking name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _parkingAddressController,
                    decoration: InputDecoration(labelText: 'Parking Address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter parking address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _parkingPriceController,
                    decoration: InputDecoration(labelText: 'Parking Price'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter parking price';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  if (unassignedSupervisors.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: unassignedSupervisors.length,
                        itemBuilder: (context, index) {
                          final supervisor = unassignedSupervisors[index];
                          return ListTile(
                            title: Text('${supervisor['nom_sup']} ${supervisor['prenom_sup']}'),
                            onTap: () {
                              setState(() {
                                selectedSupervisor = supervisor;
                              });
                            },
                            selected: selectedSupervisor == supervisor,
                          );
                        },
                      ),
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && selectedSupervisor != null) {
                        _submitForm();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void fetchUnassignedSupervisors() async {
    final url = 'http://localhost:8080/superviseurs/unassigned';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          unassignedSupervisors = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
      } else {
        print('Failed to fetch unassigned supervisors: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching unassigned supervisors: $e');
    }
  }

  void _submitForm() async {
    String parkingName = _parkingNameController.text;
    String parkingAddress = _parkingAddressController.text;
    double price= _parkingPriceController.text as double;
    Map<String, dynamic> data = {
      'nom_pk': parkingName,
      'adresse_pk': parkingAddress,
      'price' : price,
      'superviseur': {
        'id_sup': selectedSupervisor!['id_sup'],
      },
    };

    String jsonData = jsonEncode(data);

    final addParkingUrl = 'http://localhost:8080/parking';

    try {
      final response = await http.post(
        Uri.parse(addParkingUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );

      print('Response Body: ${response.body}');
      print('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Parking added successfully!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(
                  'Failed to add parking. Please try again later.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
                'An unexpected error occurred. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }

    _parkingNameController.clear();
    _parkingAddressController.clear();
    _parkingPriceController.clear();
  }
}
