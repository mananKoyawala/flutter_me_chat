import 'package:flutter/material.dart';
import 'package:me_chat/Packages/Package_Export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: TextFW400(
          text: "Home Screen",
          fontSize: 30,
          textcolor: black,
        ),
      ),
    );
  }
}
