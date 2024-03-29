// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:me_chat/Controller/SplashController.dart';
import 'package:me_chat/Screens/SplashScreen.dart';
import 'package:me_chat/Utils/Services/NavigatorServices.dart';
import 'Controller/Login_Controller.dart';
import 'Controller/Network/Dependency_Injection.dart';
import 'Packages/Constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_notification_channel/notification_visibility.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) =>
      {DependencyInjection.init(), initializeFirebase(), runApp(MyApp())});
}

initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FlutterNotificationChannel.registerNotificationChannel(
      description: 'For showing message notifications',
      id: 'chats',
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: 'Chats',
      enableSound: true,
      allowBubbles: true,
      showBadge: true,
      enableVibration: true,
      visibility: NotificationVisibility.VISIBILITY_PUBLIC);
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
