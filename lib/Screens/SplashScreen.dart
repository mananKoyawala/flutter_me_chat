import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/SplashController.dart';
import '../Packages/Constants.dart';
import '../Packages/Package_Export.dart';

class SplashScreen extends GetWidget<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 47, 47, 47),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: const Color.fromARGB(255, 47, 47, 47),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/icons/chatAppLogo2.png',
              height: DP.dHeight(5),
            ),
          ),
          CP(
            v: 40,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFW400(
                    text: "MADE IN INDIA WITH ❤️",
                    fontSize: 18,
                    textcolor: white,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
