import 'package:flutter/material.dart';
import 'package:me_chat/Packages/Constants.dart';
import 'package:me_chat/Utils/Constants.dart';
import 'package:me_chat/Utils/Services/NavigatorServices.dart';

class Dialogs {
  static void showProgressBar() {
    showDialog(
        context: ncontext,
        builder: (_) => Center(
              child: CircularProgressIndicator(
                color: appColor,
              ),
            ));
  }

  static void removeProgressBar() {
    Nav.pop();
  }
}
