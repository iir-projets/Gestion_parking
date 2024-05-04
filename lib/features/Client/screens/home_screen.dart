import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:login_signup/util/app_info_list.dart';
import 'package:login_signup/util/parking_widget.dart';
import 'package:lottie/lottie.dart';

import '../../../util/app_styles.dart';
import 'booking_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                            Text(
                                "Good Morning",style: Styles.headLineStyle3,
                                    ),

                              Text(
                                  "Book a Spot",style:Styles.headLineStyle,
                                 ),

                                     ],
                  ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage(
                              'Assets/images/Citing Carpark.png'
                          )
                        )
                      ),
                    )
                  ],
                ),
                const Gap(25),

               /* Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFF4F6FD),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: const Row(
                    children: [
                      Icon(FluentSystemIcons.ic_fluent_search_regular, color: Color(0xFFB3B3B3)),
                      SizedBox(width: 10), // Add spacing between icon and text
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: TextStyle(color: Colors.grey), // Adjust hint text color
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: Colors.black),
                          cursorColor: Colors.black,
                          // Add your logic to handle search functionality here
                        ),
                      ),
                    ],
                  ),
                ),*/
                const Gap(40),
                //timer if time allows it
                /* bool isParking = false;
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Clock is Ticking! ",style: Styles.headLineStyle2),
                    Text("Timer",style: Styles.headLineStyle4),

                  ],
                )*/
              ]
            ),
          ),
        //const Gap(15),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Lottie.asset(
              'Assets/animation/running_car.json',
              fit: BoxFit.cover,
            ),
          ),

          const Gap(15),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: primaryGradient,
                ),
                child: Center(
                  child: Text(
                    'Book now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Gap(20), // Add some spacing between the button and the "parkings section"


          Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Parkings ",style: Styles.headLineStyle2),
          InkWell(
            onTap: (){
              print("You are tapped");
            },
            child: Text("view all",style: Styles.headLineStyle4),
          ),

            ]
            ),
      ),//Parking
          const Gap(15),
           SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left:20),
              child:  Row(
                children: parkingList.map((parking)=>ParkingWidget(parking: parking)).toList()


              )),
          const Gap(15),




        ],
      )
    );
  }
}
