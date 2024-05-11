import 'package:flutter/material.dart';

class SpotsListPage extends StatefulWidget {
  const SpotsListPage({Key? key}) : super(key: key);

  @override
  _SpotsListPageState createState() => _SpotsListPageState();
}

class _SpotsListPageState extends State<SpotsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Parking'),
      ),
      body: Center(
        child: ListView(
      children: [
      DataTable(
      columns: const [
          DataColumn(label: Text('Parking ID')),
          DataColumn(label: Text('Parking Name')),
          DataColumn(label: Text('Address')),
          DataColumn(label: Text('Supervisor')),
        ],
          rows: const [
            DataRow(cells: [
              DataCell(Text('1')),
              DataCell(Text('Parking A')),
              DataCell(Text('Address A')),
              DataCell(Text('Supervisor A')),
            ]),
            DataRow(cells: [
              DataCell(Text('2')),
              DataCell(Text('Parking B')),
              DataCell(Text('Address B')),
              DataCell(Text('Supervisor B')),
            ]),
    // Add more DataRow widgets for additional parking information
          ],
      ),
    ],),
      ),
    );
  }
}
