import 'package:flutter/material.dart';
import '/Superviseur/Place/pages/add.dart';
import '/Superviseur/Place/pages/remove.dart';
import '/Superviseur/Place/pages/modify.dart';
import '/Superviseur/Place/pages/list.dart';

class SpotsPage extends StatelessWidget {
  const SpotsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final int idsup=1;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0), // Adjusted top padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Spots Page", // Headline text
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SpotsAddPage()));
                    },
                    child: _buildContainer("Add", Icons.add),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SpotsRemovePage()));
                    },
                    child: _buildContainer("Remove", Icons.remove),
                  ),
                ],
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SpotsModifyPage()));
                    },
                    child: _buildContainer("Modify", Icons.settings),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SpotsListPage()));
                    },
                    child: _buildContainer("List", Icons.panorama_fish_eye),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(String text, IconData iconData) {
    return Container(
      width: 200, // Reduced width to fit two containers in a row
      height: 300,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 50,
            color: Colors.blue,
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
