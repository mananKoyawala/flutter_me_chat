import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_chat/Packages/Package_Export.dart';
import 'package:me_chat/Screens/HomeScreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  Nav.pushMaterialReplacement(HomeScreen());
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
