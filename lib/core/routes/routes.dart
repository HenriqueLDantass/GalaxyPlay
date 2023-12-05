import 'package:galaxyplay/modules/home/binding/home_binding.dart';
import 'package:galaxyplay/modules/home/pages/home_page.dart';
import 'package:galaxyplay/modules/splash/binding/splash_binding.dart';
import 'package:galaxyplay/modules/splash/pages/splash_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class AppRoutes {
  static final pages = <GetPage>[
    GetPage(
      name: NamedRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
        name: NamedRoutes.splashRoute,
        page: () => const SplashPage(),
        binding: SplashBinding()),
  ];
}

abstract class NamedRoutes {
  static const String productWidget = "/product";
  static const String splashRoute = "/splash";
  static const String signRoute = "/sign";
  static const String sigUpRoute = "/singUp";
  static const String home = "/home";
}
