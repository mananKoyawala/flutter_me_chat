// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:me_chat/Controller/SplashController.dart';
import 'package:me_chat/Screens/SplashScreen.dart';
import 'package:me_chat/Utils/Services/NavigatorServices.dart';
import 'Controller/Login_Controller.dart';
import 'Packages/Constants.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => {initializeFirebase(), runApp(MyApp())});
}

initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  SplashController ctr = Get.put(SplashController());
  LoginController ctrL = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      navigatorKey: navigatorKey,
      darkTheme: ThemeData(
          primaryColor: Colors.green,
          primarySwatch: Colors.green,
          fontFamily: 'roboto',
          scaffoldBackgroundColor: white,
          appBarTheme: AppBarTheme(
              surfaceTintColor: white,
              backgroundColor: white,
              shadowColor: Colors.grey.shade50,
              centerTitle: true,
              elevation: 2,
              titleTextStyle: TextStyle(
                color: black,
                fontWeight: FontWeight.normal,
                fontSize: 19,
                backgroundColor: white,
              ))),
      theme: ThemeData(
          primaryColor: Colors.green,
          primarySwatch: Colors.green,
          fontFamily: 'roboto',
          scaffoldBackgroundColor: white,
          appBarTheme: AppBarTheme(
              surfaceTintColor: white,
              backgroundColor: white,
              shadowColor: Colors.grey.shade50,
              centerTitle: true,
              elevation: 2,
              titleTextStyle: TextStyle(
                color: black,
                fontWeight: FontWeight.normal,
                fontSize: 19,
                backgroundColor: white,
              ))),
    );
  }
}
