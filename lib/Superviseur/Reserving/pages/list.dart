import 'package:flutter/material.dart';

class SuperviseurListPage extends StatefulWidget {
  const SuperviseurListPage({Key? key}) : super(key: key);

  @override
  _SuperviseurListPageState createState() => _SuperviseurListPageState();
}

class _SuperviseurListPageState extends State<SuperviseurListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Superviseur'),
      ),
      body: Center(
        child: ListView(
    children: [
    DataTable(
    columns: [
    DataColumn(label: Text('ID')),
    DataColumn(label: Text('First Name')),
    DataColumn(label: Text('Last Name')),
    DataColumn(label: Text('Email')),
    DataColumn(label: Text('Password')),
    ],
    rows: [
    DataRow(cells: [
    DataCell(Text('1')),
    DataCell(Text('John')),
    DataCell(Text('Doe')),
    DataCell(Text('john.doe@example.com')),
    DataCell(Text('johndoe123')),
    ]),
    DataRow(cells: [
    DataCell(Text('2')),
    DataCell(Text('Jane')),
    DataCell(Text('Smith')),
    DataCell(Text('jane.smith@example.com')),
    DataCell(Text('janesmith123')),
    ]),
    // Add more DataRow widgets for additional supervisor information
    ],
    ),
    ],
    ),
      ),
    );
  }
}