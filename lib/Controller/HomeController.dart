import 'package:get/get.dart';

import 'API/Apis.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    APIs.currentUserInfo();
  }
}
