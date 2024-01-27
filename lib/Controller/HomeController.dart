import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:me_chat/Controller/API/Apis.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  var isSearching = false.obs;
  final searchCtr = TextEditingController();

  changeIsSearching() {
    isSearching.toggle();
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    APIs.updateUserActiveStatus(true);
  }

  @override
  void onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
    APIs.updateUserActiveStatus(false);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (APIs.auth.currentUser != null) {
      //When user login or first time is not called
      switch (state) {
        case AppLifecycleState.resumed:
          // App is in the foreground
          // Add actions to handle when the app comes to the foreground
          APIs.updateUserActiveStatus(true);
          break;
        case AppLifecycleState.inactive:
        case AppLifecycleState.paused:
          // App is in the background or transitioning to the background
          // Add actions to handle when the app goes into the background
          APIs.updateUserActiveStatus(false);
          break;
        case AppLifecycleState.detached:
        // App is terminated
        // APIs.updateUserActiveStatus(false);
        // break;
        case AppLifecycleState.hidden:
        // APIs.updateUserActiveStatus(false);
        // break;
      }
    }
  }
}
