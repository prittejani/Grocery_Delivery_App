import 'dart:async';
import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_delivery_app/screens/home_screen.dart';
import 'package:grocery_delivery_app/screens/login_screen.dart';
import 'package:lottie/lottie.dart';



class SplashScreen extends StatefulWidget {
  static const  String id = "splash-screen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {

      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        log("=++++++++++++++++++++++++++++++++++++++++++++++++++++${user}");
        if(user == null){
          Get.offNamed(LoginScreen.id);
        }
        else{
          Get.offNamed(HomeScreen.id);
        }
      }
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height / 1.8,
              width: size.width/1.2,
              child: Column(
                children: [
                  Lottie.asset('assets/lottie/delivery.json'),
                  AnimatedTextKit(animatedTexts: [ScaleAnimatedText(duration: Duration(seconds: 5),"Grocify Delivery", textStyle: TextStyle(fontSize: 35,color:Colors.green),)])
                ],
              ),
            ),
            //Container(transform: Matrix4.identity()..rotateZ(15*3.14/180,),height: 70,width: 70,color: Colors.redAccent,child: Lottie.asset("assets/lottie/leaves .json")),
          ],
        ),
      ),
    );
  }
}
