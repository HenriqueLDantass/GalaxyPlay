import 'package:flutter/material.dart';
import 'package:galaxyplay/core/routes/routes.dart';
import 'package:galaxyplay/modules/home/controller/home_controller.dart';
import 'package:galaxyplay/modules/home/pages/home_page.dart';
import 'package:galaxyplay/modules/login/controller/login_controller.dart';
import 'package:galaxyplay/modules/splash/pages/splash_page.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<HomeController>(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      initialRoute: NamedRoutes.splashRoute,
      getPages: AppRoutes.pages,
    );
  }
}
