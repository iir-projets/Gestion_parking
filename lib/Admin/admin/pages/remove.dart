import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ParkingRemovePage extends StatefulWidget {
  const ParkingRemovePage({Key? key}) : super(key: key);

  @override
  _ParkingRemovePageState createState() => _ParkingRemovePageState();
}

class _ParkingRemovePageState extends State<ParkingRemovePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _idController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _capacityController = TextEditingController();

  bool _isFetchingDetails = false;
  bool _detailsFetched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remove Parking'),
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
                    'Remove Parking',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _idController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Parking ID'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter parking ID';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  !_detailsFetched
                      ? _isFetchingDetails
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isFetchingDetails = true;
                        });
                        fetchParkingDetails(
                            int.parse(_idController.text));
                      }
                    },
                    child: Text('Fetch Parking Details'),
                  )
                      : SizedBox(),
                  SizedBox(height: 20),
                  if (_detailsFetched)
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _submitForm();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      child: Text('Delete Parking'),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void fetchParkingDetails(int parkingId) async {
    try {
      final parking = await _getParkingDetails(parkingId);
      setState(() {
        _detailsFetched = true;
        _isFetchingDetails = false;
      });
    } catch (e) {
      print('Error fetching parking details: $e');
      setState(() {
        _isFetchingDetails = false;
      });
    }
  }

  Future<Map<String, dynamic>> _getParkingDetails(int parkingId) async {
    final url = 'http://localhost:8080/parking/$parkingId';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    return jsonDecode(body);
  }

  void _submitForm() async {
    String id = _idController.text;

    try {
      final response = await _deleteParking(id);
      if (response.statusCode == 200) {
        print('Parking deleted successfully!');
      } else {
        print('Failed to delete parking');
      }
    } catch (e) {
      print('An unexpected error occurred: $e');
    }

    _idController.clear();
  }

  Future<http.Response> _deleteParking(String id) async {
    final url = 'http://localhost:8080/parking/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response;
  }
}
