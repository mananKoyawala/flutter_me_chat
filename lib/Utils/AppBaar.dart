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
