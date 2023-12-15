import 'package:flutter/material.dart';
import 'package:galaxyplay/core/routes/routes.dart';
import 'package:galaxyplay/modules/home/pages/home_page.dart';
import 'package:galaxyplay/teste.dart';

import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      initialBinding: AppBindings(),
    );
  }
}
