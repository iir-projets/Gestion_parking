
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/features/Client/screens/home_screen.dart';
import 'package:login_signup/features/Client/screens/parkingPage.dart';



class bottom_bar extends StatefulWidget {
  const bottom_bar({super.key});

  @override
  State<bottom_bar> createState() => _BottomBarState();
}

class _BottomBarState extends State<bottom_bar> {
 int _selectedIndex=1;
  static final List<Widget> _widgetOptions=<Widget>
  [
    HomeScreen(),
    ParkingCarousel(),
    const Text("Ticket"),
    const Text("Profile"),
  ];

  void _onItemTapped(int i)
  {setState(() {
    _selectedIndex=i;
    print('${_selectedIndex}');
  });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body : Center(
        child: _widgetOptions[_selectedIndex],
      ),

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 10,
        selectedItemColor: Color(0xFF004AAD),
        type: BottomNavigationBarType.fixed,// might remove
        unselectedItemColor: Colors.blueGrey,
        items: const [

        BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_home_regular)
            ,activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled)
            ,label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.local_parking),label: "Parking"),
        BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_ticket_regular)
            ,activeIcon: Icon(FluentSystemIcons.ic_fluent_ticket_filled)
            ,label: "Ticket"),
        BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_person_regular)
            ,activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled)
            ,label: "Profile")
      ],

      ),
    );
  }
}
