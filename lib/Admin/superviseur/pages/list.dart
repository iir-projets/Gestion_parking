import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SuperviseurListPage extends StatefulWidget {
  const SuperviseurListPage({Key? key}) : super(key: key);

  @override
  _SuperviseurListPageState createState() => _SuperviseurListPageState();
}

class _SuperviseurListPageState extends State<SuperviseurListPage> {
  List<dynamic> superviseurs = [];

  @override
  void initState() {
    super.initState();
    fetchSuperviseurs(); // Fetch data when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Superviseurs'),
      ),
      body:
        SingleChildScrollView(
          child: DataTable(
            columns: [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('First Name')),
              DataColumn(label: Text('Last Name')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Password')),
            ],
            rows: superviseurs.map<DataRow>((superviseur) {
              return DataRow(
                cells: [
                  DataCell(Text('${superviseur['id_sup']}')),
                  DataCell(Text('${superviseur['nom_sup']}')),
                  DataCell(Text('${superviseur['prenom_sup']}')),
                  DataCell(Text('${superviseur['email_sup']}')),
                  DataCell(Text('${superviseur['mdp_sup']}')),
                ],
              );
            }).toList(),
          ),
        ),

    );
  }

  void fetchSuperviseurs() async {
    print("fetch started");
    final url = 'http://localhost:8080/superviseurs';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      print('Response Data: $json'); // Print the response data for inspection

      // Assign the response data directly to the 'superviseurs' list
      setState(() {
        superviseurs = json; // Assign the response data directly
      });
    } catch (e) {
      print('Error fetching data: $e'); // Print any error that occurs during fetching
    }

    print("fetch Completed");
  }
}
