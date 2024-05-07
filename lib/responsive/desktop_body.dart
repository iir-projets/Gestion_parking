import 'package:flutter/material.dart';
import '../constants.dart';


class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // open drawer
            myDrawer,
            Expanded( // Fix: Use parentheses for Expanded widget
              flex: 6,
              child: sidebarController.pages[sidebarController.index.value], // Assuming sidebarController.pages is a List<Widget> and index.value is the selected index
            ),


          ],
        ),
      ),
    );
  }
}
