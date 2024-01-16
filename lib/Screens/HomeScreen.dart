import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:me_chat/Packages/Package_Export.dart';
import 'package:me_chat/Utils/Constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CP(
          h: 16,
          child: IconButtons(
            onTap: () {},
            icon: const Icon(CupertinoIcons.home),
          ),
        ),
        title: Text(APP_NAME),
        actions: [
          IconButtons(
            onTap: () {},
            icon: const Icon(
              CupertinoIcons.search,
              size: 23,
            ),
          ),
          IconButtons(
            onTap: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      floatingActionButton: Margine(
        margin: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.blue,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: radius(50)),
          child: Icon(Icons.add_comment, color: white),
        ),
      ),
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
