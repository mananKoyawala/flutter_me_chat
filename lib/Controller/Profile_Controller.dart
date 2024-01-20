import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:me_chat/Packages/Package_Export.dart';

class ProfileController extends GetxController {
  final nameCtr = TextEditingController();
  final aboutCtr = TextEditingController();

  changeNameCtr(String val) {
    nameCtr.text = val;
  }

  changeAboutCtr(String val) {
    aboutCtr.text = val;
  }
}
