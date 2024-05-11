import 'package:flutter/material.dart';

class SpotsModifyPage extends StatefulWidget {
  const SpotsModifyPage({Key? key}) : super(key: key);

  @override
  _SpotsModifyPageState createState() => _SpotsModifyPageState();
}

class _SpotsModifyPageState extends State<SpotsModifyPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _parkingNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  String? _selectedSupervisor;

  List<String> supervisors = ['Supervisor A', 'Supervisor B', 'Supervisor C']; // Example list of supervisors

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modify Parking'),
      ),
      body: Center( // Centering horizontally
        child: Container(
          width: 800,
          height: 800,// Adjust the width as needed
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
                    controller: _addressController,
                    decoration: InputDecoration(labelText: 'Address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedSupervisor,
                    onChanged: (value) {
                      setState(() {
                        _selectedSupervisor = value;
                      });
                    },
                    items: supervisors.map((String supervisor) {
                      return DropdownMenuItem<String>(
                        value: supervisor,
                        child: Text(supervisor),
                      );
                    }).toList(),
                    decoration: InputDecoration(labelText: 'Supervisor'),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select supervisor';
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
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    String parkingName = _parkingNameController.text;
    String address = _addressController.text;
    String supervisor = _selectedSupervisor!;

    // Perform any actions needed with the form data
    print('Parking Name: $parkingName');
    print('Address: $address');
    print('Supervisor: $supervisor');

    _parkingNameController.clear();
    _addressController.clear();
    setState(() {
      _selectedSupervisor = null;
    });

    // You can also navigate back to the previous screen or perform any other action here
  }

}
