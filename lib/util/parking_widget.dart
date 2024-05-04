
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:login_signup/util/app_layout.dart';

import 'app_styles.dart';

class ParkingWidget extends StatelessWidget {
   final Map<String,dynamic> parking;
  const ParkingWidget({super.key,required this.parking});

  @override
  Widget build(BuildContext context) {
    print('Parking is ${parking['price']}');

final size=AppLayout.getSize(context);
    return Container(
      width: size.width*0.6,
      height: 350,
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 17),
        margin: const EdgeInsets.only(right: 17,top: 5),
      decoration: BoxDecoration(
        color: Styles.secondaryColor,

        borderRadius: BorderRadius.circular(24),
        boxShadow: [
      BoxShadow(
      color: Colors.grey.shade200,
        blurRadius: 20,
        spreadRadius: 5,


      ),
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Styles.primaryColor,
              image:  DecorationImage(
                fit:BoxFit.cover,
                image: AssetImage(
                  "Assets/images/${parking['image']}"
                )
              )
            ),
          ),
          const Gap(15),
          Text("${parking['place']}",
          style: Styles.headLineStyle2.copyWith(color : Styles.primaryColor)),
          const Gap(2),
          Text("${parking['destination']}",
              style: Styles.headLineStyle3.copyWith(color : Colors.white)),
          const Gap(5),
          Text('\$${parking['price']}/hour',
              style: Styles.headLineStyle.copyWith(color : Colors.white)),


        ],

      )
    );
  }
}
