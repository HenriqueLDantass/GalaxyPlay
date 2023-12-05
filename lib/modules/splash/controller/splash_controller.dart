import 'package:galaxyplay/modules/home/controller/home_controller.dart';
import 'package:galaxyplay/modules/login/pages/login_page.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // É a mesma coisa que initState()
    super.onInit();
    telaLogin();
    Get.put(HomeController());
  }

  telaLogin() {
    Future.delayed(const Duration(seconds: 5), () {
      //alterar nome
      Get.off(const LoginPage());
    });
  }
}
