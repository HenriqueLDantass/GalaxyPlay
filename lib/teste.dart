import 'package:galaxyplay/modules/message/controller/message_controller.dart';
import 'package:galaxyplay/modules/splash/controller/splash_controller.dart';
import 'package:get/get.dart';
import 'package:galaxyplay/core/Auth/controller/auth_controller.dart';
import 'package:galaxyplay/modules/home/controller/home_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(AuthController());
    Get.put(MessageController());
    Get.put(HomeController());
  }
}
