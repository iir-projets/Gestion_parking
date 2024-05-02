
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' ;
import 'package:flutter/widgets.dart';
import 'regScreen.dart';

import 'LoginScreen.dart';

class WelcomeScreen extends StatelessWidget
{
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(

      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.45, 1.0],
            colors: [
              Color.fromRGBO(165, 165, 224, 1),
              Color.fromRGBO(151, 220, 233, 1),
            ]
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Image(image: AssetImage('Assets/images/carp2.png'))
            ) ,
            SizedBox(
                height: 100,
            ),
            Text("If you're in need of a spot !",style:TextStyle(
                fontSize: 30,
              color: Color(0xFF004AAD),

            ),),

            SizedBox(height: 30,),
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                border: Border.all(color:Colors.white)
              ),
              child: Center(child:Text('SIGN IN',style:TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                fontWeight: FontWeight.bold
              ),),),
              
              ),
            ),
            SizedBox(height: 30,),
            GestureDetector(onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => regScreen()));
            },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                border: Border.all(color:Colors.white)
              ),
              child: const Center(child:Text('SIGN UP',style:TextStyle(
                  fontSize: 20,
                  color: Color(0xFF004AAD),
              
              
                  fontWeight: FontWeight.bold
              ),),),
              
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom:50.0),
              child: Text('Book a spot whenever wherever ;)',style:TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),),
            ),

          ]
        ),
      ),

    );
  }
}