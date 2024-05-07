import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SuperviseurRemovePage extends StatefulWidget {
  const SuperviseurRemovePage({Key? key}) : super(key: key);

  @override
  _SuperviseurRemovePageState createState() => _SuperviseurRemovePageState();
}

class _SuperviseurRemovePageState extends State<SuperviseurRemovePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _idController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isFetchingDetails = false; // Track whether details are being fetched
  bool _detailsFetched = false; // Track whether details have been fetched

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remove Supervisor'),
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
                    'Remove Supervisor',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _idController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Supervisor ID'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter supervisor ID';
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
                        fetchSupervisorDetails(int.parse(_idController.text));
                      }
                    },
                    child: Text('Fetch Supervisor Details'),
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
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      child: Text('Delete Supervisor'),
                    ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void fetchSupervisorDetails(int supervisorId) async {
    try {
      final supervisor = await _getSupervisorDetails(supervisorId);
      setState(() {
        _detailsFetched = true; // Set detailsFetched to true
        _isFetchingDetails = false;
      });
    } catch (e) {
      print('Error fetching supervisor details: $e');
      setState(() {
        _isFetchingDetails = false;
      });
    }
  }

  Future<Map<String, dynamic>> _getSupervisorDetails(int supervisorId) async {
    final url = 'http://localhost:8080/superviseur/$supervisorId';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    return jsonDecode(body);
  }

  void _submitForm() async {
    // Get the supervisor ID
    String id = _idController.text;

    // Perform the delete operation
    try {
      final response = await _deleteSupervisor(id);
      if (response.statusCode == 200) {
        // Successfully deleted
        // You may want to show a success message or navigate back to the previous screen
        print('Supervisor deleted successfully!');
      } else {
        // Failed to delete
        // You may want to show an error message or handle the failure accordingly
        print('Failed to delete supervisor');
      }
    } catch (e) {
      // Handle network error
      print('An unexpected error occurred: $e');
    }

    // Clear the form fields after submission
    _idController.clear();
  }

  Future<http.Response> _deleteSupervisor(String id) async {
    final url = 'http://localhost:8080/superviseur/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response;
  }
}
