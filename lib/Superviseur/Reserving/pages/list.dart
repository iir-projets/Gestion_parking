import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReservationsListPage extends StatefulWidget {
  const ReservationsListPage({Key? key}) : super(key: key);

  @override
  _ReservationsListPageState createState() => _ReservationsListPageState();
}

class _ReservationsListPageState extends State<ReservationsListPage> {
  List<dynamic> reservations = [];

  @override
  void initState() {
    super.initState();
    fetchReservations(); // Fetch reservations when the page loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Reservations'),
      ),
      body: reservations.isEmpty ? _buildNoReservationsWidget() : _buildReservationsList(),
    );
  }

  Widget _buildNoReservationsWidget() {
    return Center(
      child: Text(
        'No reservations yet',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildReservationsList() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: reservations.map<Widget>((reservation) {
            return Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${reservation['id']}'),
                  SizedBox(height: 5),
                  Text('Timestamp: ${reservation['timestamp']}'),
                  SizedBox(height: 5),
                  Text('Duration: ${reservation['duration']}'),
                  SizedBox(height: 5),
                  Text('Price: ${reservation['price']}'),
                  SizedBox(height: 5),
                  Text('Client: ${reservation['client']['firstName']} ${reservation['client']['lastName']}'),
                  SizedBox(height: 5),
                  Text('Parking ID: ${reservation['parking']['id_pk']}'),
                  SizedBox(height: 5),
                  Text('Spot ID: ${reservation['spot']['num_pl']}'),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void fetchReservations() async {
    final url = Uri.parse('http://localhost:8080/reservations');
    try {
      final response = await http.get(url);
      final body = response.body;
      final json = jsonDecode(body);
      setState(() {
        reservations = json;
      });
    } catch (e) {
      print('Error fetching reservations: $e');
    }
  }
}
