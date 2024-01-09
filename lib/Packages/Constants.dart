import 'package:flutter/material.dart';
import 'package:me_chat/Packages/Package_Export.dart';
import 'CustomeTexts.dart';
import 'package:fluttertoast/fluttertoast.dart';

Color white = Colors.white;
Color black = Colors.black;
Color blackO_30 = const Color(0xFF000000).withOpacity(0.30);
Color blackO_50 = const Color(0xFF000000).withOpacity(0.50);
Color rippleColor = Colors.grey.shade500;
Color blackO7 = const Color(0xFF000000).withOpacity(0.7);
Color green = const Color(0xFF5EC401);
Color textColor1 = const Color(0xFF37474F);
Color searchColor = const Color(0xff747b84);
Color searchColor2 = const Color(0xffF4F6F9);

class DP {
  static dHeight(BuildContext context, int dp) {
    return MediaQuery.of(context).size.height / dp;
  }

  static dWidth(BuildContext context, int dp) {
    return MediaQuery.of(context).size.width / dp;
  }

  static infinity(BuildContext context) {
    return double.infinity;
  }

  static height(BuildContext context, double h) {
    return MediaQuery.of(context).size.height * h;
  }

  static width(BuildContext context, double w) {
    return MediaQuery.of(context).size.height * w;
  }

  static visibility(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom == 0;
  }
}

unfocus() {
  FocusManager.instance.primaryFocus?.unfocus();
}

class Nav {
  static push(BuildContext context, String routeName) {
    return Navigator.pushNamed(context, routeName);
  }

  static pushMaterial(BuildContext context, Widget widget) {
    return Navigator.push(context, MaterialPageRoute(builder: (_) => widget));
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }

  static closeDrawer(BuildContext context) {
    Scaffold.of(context).closeDrawer();
  }
}

sizeH10() {
  return const SizedBox(height: 10);
}

sizeW10() {
  return const SizedBox(width: 10);
}

sizeH25() {
  return const SizedBox(height: 25);
}

sizeW25() {
  return const SizedBox(width: 25);
}

sizeH(double h) {
  return SizedBox(height: h);
}

sizeW(double w) {
  return SizedBox(width: w);
}

radius(double d) {
  return BorderRadius.circular(d);
}

visible(BuildContext context) {
  return MediaQuery.of(context).viewInsets.bottom == 0;
}

toast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

Future<dynamic> dialogSuccess(BuildContext context) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: radius(10)),
            backgroundColor: white,
            icon: Icon(
              Icons.check_circle,
              color: green,
              size: 65,
            ),
            content: TextFW500(
              text: 'Product Added',
              fontSize: 25,
              textColor: textColor1,
              textAlign: TextAlign.center,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
            actions: [
              Center(
                  child: ButtonWithSimpleText(
                onTap: () {
                  Nav.pop(context);
                },
                borderRadius: radius(10),
                height: 45,
                width: 175,
                backgroundColor: green,
                title: Text("OK",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: white)),
              )),
              sizeH(20)
            ],
          ));
}

Future<dynamic> dialogEdit(BuildContext context) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: radius(10)),
            backgroundColor: white,
            icon: const Icon(
              Icons.upcoming_rounded,
              color: Colors.blue,
              size: 65,
            ),
            content: TextFW500(
              text: 'Details are Edited!!!',
              fontSize: 25,
              textColor: textColor1,
              textAlign: TextAlign.center,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
            actions: [
              Center(
                  child: ButtonWithSimpleText(
                onTap: () {
                  Nav.pop(context);
                },
                borderRadius: radius(10),
                height: 45,
                width: 175,
                backgroundColor: Colors.blue,
                title: Text("OK",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: white)),
              )),
              sizeH(20)
            ],
          ));
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (var i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}

Future<void> decisionDialog(BuildContext context, String title, String negative,
    String positive, VoidCallback onPositive, VoidCallback onNegative) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return ClipRRect(
        borderRadius: radius(20),
        child: AlertDialog(
          // <-- SEE HERE
          title: const Text('Log out'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(title),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: onNegative,
              child: Text(negative),
            ),
            TextButton(
              onPressed: onPositive,
              child: Text(positive),
            ),
          ],
        ),
      );
    },
  );
}
