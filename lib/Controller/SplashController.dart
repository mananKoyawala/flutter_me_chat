import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:me_chat/Packages/Constants.dart';
import 'package:me_chat/Screens/Auth/Login_Screen.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    goTo();
  }

  Future goTo() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    Nav.pushMaterialReplacement(const LoginScreen());
  }
}
