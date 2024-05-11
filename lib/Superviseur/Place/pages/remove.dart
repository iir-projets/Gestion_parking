import 'package:flutter/material.dart';

class SpotsRemovePage extends StatefulWidget {
  const SpotsRemovePage({Key? key}) : super(key: key);

  @override
  _SpotsRemovePageState createState() => _SpotsRemovePageState();
}

class _SpotsRemovePageState extends State<SpotsRemovePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remove Parking'),
      ),
      body: Center(
        child: Text('Remove Parking Page Content'),
      ),
    );
  }
}
