import 'package:galaxyplay/core/routes/routes.dart';
import 'package:galaxyplay/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // É a mesma coisa que initState()
    super.onInit();
    telaLogin();
    Get.put(HomeController());
    // Get.put(AuthController());
  }

  telaLogin() {
    Future.delayed(const Duration(seconds: 2), () {
      //alterar nome
      Get.offNamed(NamedRoutes.loginRouter);
    });
  }
}
