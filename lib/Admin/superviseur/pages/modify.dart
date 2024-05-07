import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SuperviseurModifyPage extends StatefulWidget {
  const SuperviseurModifyPage({Key? key}) : super(key: key);

  @override
  _SuperviseurModifyPageState createState() => _SuperviseurModifyPageState();
}

class _SuperviseurModifyPageState extends State<SuperviseurModifyPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _idController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String? selectedSupervisorName;
  String? selectedSupervisorEmail;
  String? selectedSupervisorPassword;
  bool _isFetchingDetails = false; // Track whether details are being fetched
  bool _detailsFetched = false; // Track whether details have been fetched

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modify Supervisor'),
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
                    'Modify Supervisor',
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
                    Column(
                      children: [
                        TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(labelText: 'First Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter first name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(labelText: 'Last Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter last name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            }
                            // Check if the email is valid and doesn't exist
                            if (value != selectedSupervisorEmail && !isValidEmail(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _submitForm();
                            }
                          },
                          child: Text('Submit'),
                        ),
                      ],
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
        selectedSupervisorName = '${supervisor['nom_sup']} ${supervisor['prenom_sup']}';
        selectedSupervisorEmail = supervisor['email_sup'];
        selectedSupervisorPassword = supervisor['mdp_sup'];
        _firstNameController.text = supervisor['nom_sup'];
        _lastNameController.text = supervisor['prenom_sup'];
        _emailController.text = supervisor['email_sup'];
        _passwordController.text = supervisor['mdp_sup'];
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
    // Get the modified values from the form fields
    String id = _idController.text;
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // Perform the update operation with the modified values
    try {
      final response = await _updateSupervisorDetails(id, firstName, lastName, email, password);
      if (response.statusCode == 200) {
        // Successfully updated
        // Show a snackbar message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Supervisor details updated successfully!'),
            duration: Duration(seconds: 2), // Adjust the duration as needed
          ),
        );
        print('Supervisor details updated successfully!');
      } else {
        // Failed to update
        // You may want to show an error message or handle the failure accordingly
        print('Failed to update supervisor details');
      }
    } catch (e) {
      // Handle network error
      print('An unexpected error occurred: $e');
    }

    // Clear the form fields after submission
    _idController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  Future<http.Response> _updateSupervisorDetails(String id, String firstName, String lastName, String email, String password) async {
    final url = 'http://localhost:8080/superviseur/$id';
    final uri = Uri.parse(url);

    // Prepare the updated data
    Map<String, String> updatedData = {
      'email_sup': email,
      'nom_sup': firstName,
      'prenom_sup': lastName,
      'mdp_sup': password,
    };

    // Send a PUT request with the updated data
    final response = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedData),
    );

    return response;
  }

  bool isValidEmail(String email) {
    // Simple email validation using a regular expression
    // This can be improved based on your requirements
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }
}
