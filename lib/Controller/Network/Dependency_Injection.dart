import 'package:get/get.dart';
import 'package:me_chat/Controller/Network/NetChecker.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetChecker>(NetChecker(), permanent: true);
  }
}
