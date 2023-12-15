import 'package:galaxyplay/core/Auth/binding/auth_binding.dart';
import 'package:galaxyplay/modules/home/binding/home_binding.dart';
import 'package:galaxyplay/modules/home/pages/home_page.dart';
import 'package:galaxyplay/modules/login/binding/login_binding.dart';
import 'package:galaxyplay/modules/login/pages/criar_conta_page.dart';
import 'package:galaxyplay/modules/login/pages/entrar_page.dart';
import 'package:galaxyplay/modules/login/pages/login_page.dart';
import 'package:galaxyplay/modules/message/pages/message_page.dart';
import 'package:galaxyplay/modules/splash/binding/splash_binding.dart';
import 'package:galaxyplay/modules/splash/pages/splash_page.dart';
import 'package:galaxyplay/teste.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class AppRoutes {
  static final pages = <GetPage>[
    GetPage(
      name: NamedRoutes.home,
      page: () => const HomePage(),
      //binding: HomeBinding()
    ),
    GetPage(
      name: NamedRoutes.loginRouter,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: NamedRoutes.sigUpRoute,
      page: () => const CriarContaPage(),
    ),
    GetPage(
      name: NamedRoutes.signRoute,
      page: () => const EntrarPage(),
      binding: LoginBinding(),
    ),
    GetPage(
        name: NamedRoutes.splashRoute,
        page: () => const SplashPage(),
        bindings: [AppBindings()]),
  ];
}

abstract class NamedRoutes {
  static const String loginRouter = "/login";
  static const String productWidget = "/product";
  static const String splashRoute = "/splash";
  static const String signRoute = "/sign";
  static const String sigUpRoute = "/singUp";
  static const String home = "/home";
  static const String messageRouter = "/message";
}
