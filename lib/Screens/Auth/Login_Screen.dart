// ignore_for_file: must_be_immutable, depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:me_chat/Controller/Login_Controller.dart';
import 'package:me_chat/Packages/Package_Export.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  LoginController ctr = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Me Chat'),
      ),
      body: Stack(
        children: [
          Margine(
            margin: const EdgeInsets.only(top: 150),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/icons/chatAppLogo2.png',
                height: DP.dHeight(6),
              ),
            ),
          ),
          CP(
            h: 16,
            v: 30,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ButtonWithPrefixIcon(
                onTap: () {
                  // Nav.pushMaterialReplacement(HomeScreen());
                  ctr.handleGoogleBtnClick();
                },
                width: DP.infinity(),
                borderRadius: 30,
                prefixIcon: Image.asset(
                  'assets/icons/google.png',
                  height: 20,
                ),
                title: TextFW400(
                    text: 'Sign With ', fontSize: 16, textcolor: white),
                specialText:
                    TextFW600(text: 'Google', fontSize: 16, textcolor: white),
                extraSpaceInBetween: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
