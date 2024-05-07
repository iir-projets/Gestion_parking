import 'package:flutter/material.dart';

class SuperviseurRemovePage extends StatefulWidget {
  const SuperviseurRemovePage({Key? key}) : super(key: key);

  @override
  _SuperviseurRemovePageState createState() => _SuperviseurRemovePageState();
}

class _SuperviseurRemovePageState extends State<SuperviseurRemovePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remove Superviseur'),
      ),
      body: Center(
        child: Text('Remove Superviseur Page Content'),
      ),
    );
  }
}
