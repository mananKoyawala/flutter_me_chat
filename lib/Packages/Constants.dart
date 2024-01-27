import 'package:flutter/material.dart';
import 'package:me_chat/Packages/Package_Export.dart';
import 'package:me_chat/Utils/Services/NavigatorServices.dart';
import 'CustomeTexts.dart';
import 'package:fluttertoast/fluttertoast.dart';

Color white = Colors.white;
Color black = Colors.black;
Color transparent = Colors.transparent;
Color blackO_30 = const Color(0xFF000000).withOpacity(0.30);
Color blackO_50 = const Color(0xFF000000).withOpacity(0.50);
Color rippleColor = Colors.grey.shade500;
Color blackO7 = const Color(0xFF000000).withOpacity(0.7);
Color green = const Color(0xFF5EC401);
Color textColor1 = const Color(0xFF37474F);
Color searchColor = const Color(0xff747b84);
Color searchColor2 = const Color(0xffF4F6F9);

class DP {
  static dHeight(int dp) {
    return MediaQuery.of(ncontext).size.height / dp;
  }

  static dWidth(int dp) {
    return MediaQuery.of(ncontext).size.width / dp;
  }

  static infinity() {
    return double.infinity;
  }

  static height(double h) {
    return MediaQuery.of(ncontext).size.height * h;
  }

  static width(double w) {
    return MediaQuery.of(ncontext).size.height * w;
  }

  static visibility() {
    return MediaQuery.of(ncontext).viewInsets.bottom == 0;
  }
}

unfocus() {
  FocusManager.instance.primaryFocus?.unfocus();
}

class Nav {
  static push(String routeName) {
    return Navigator.pushNamed(ncontext, routeName);
  }

  static pushMaterial(Widget widget) {
    return Navigator.push(ncontext, MaterialPageRoute(builder: (_) => widget));
  }

  static pushMaterialReplacement(Widget widget) {
    return Navigator.pushReplacement(
        ncontext, MaterialPageRoute(builder: (_) => widget));
  }

  static pop() {
    Navigator.pop(ncontext);
  }

  static closeDrawer() {
    Scaffold.of(ncontext).closeDrawer();
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

visible() {
  return MediaQuery.of(ncontext).viewInsets.bottom == 0;
}

toast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0);
}

Future<dynamic> dialogSuccess() {
  return showDialog(
      context: ncontext,
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
                  Nav.pop();
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

Future<dynamic> dialogEdit() {
  return showDialog(
      context: ncontext,
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
                  Nav.pop();
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

Future<void> decisionDialog(String title, String subtitle, String negative,
    String positive, VoidCallback onNegative, VoidCallback onPositive) async {
  return showDialog<void>(
    context: ncontext,
    barrierDismissible: false, // user must tap button!
    builder: (ncontext) {
      return ClipRRect(
        borderRadius: radius(20),
        child: AlertDialog(
          // <-- SEE HERE
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(subtitle),
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

showBottomSheets(Widget widget) {
  showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      context: ncontext,
      builder: (context) => widget);
}
