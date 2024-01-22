import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  var isSearching = false.obs;
  final searchCtr = TextEditingController();

  changeIsSearching() {
    isSearching.toggle();
  }
}
