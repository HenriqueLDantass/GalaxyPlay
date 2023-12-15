import 'package:flutter/material.dart';
import 'package:galaxyplay/core/routes/routes.dart';
import 'package:get/route_manager.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00002A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Bem vindo",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(NamedRoutes.signRoute);
                },
                child: const Text("Entrar"),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(NamedRoutes.sigUpRoute);
                },
                child: const Text("Criar conta"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
