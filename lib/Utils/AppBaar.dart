import 'package:flutter/material.dart';
import '../Packages/Package_Export.dart';
import 'Constants.dart';

class AppBaar extends StatelessWidget {
  const AppBaar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DP.infinity(),
      height: 48,
      margin: const EdgeInsets.only(top: 45),
      alignment: Alignment.center,
      child: TextFW400(text: APP_NAME, fontSize: 19),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.onTap2,
    this.icon2,
    required this.title,
    this.icon1Color,
    this.text,
  });

  final VoidCallback? onTap2;
  final Widget? icon2;
  final String title;
  final Color? icon1Color;
  final Widget? text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButtons(
            onTap: () {
              Nav.pop();
            },
            icon: Icon(Icons.arrow_back, color: icon1Color ?? black)),
        text ?? TextFW600(text: title, fontSize: 20, textcolor: black),
        IconButtons(
            onTap: onTap2 ?? () {},
            icon: icon2 ?? Icon(Icons.arrow_back, color: white))
      ],
    );
  }
}
