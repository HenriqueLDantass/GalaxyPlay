import 'package:flutter/material.dart';
import 'package:galaxyplay/core/Auth/controller/auth_controller.dart';
import 'package:galaxyplay/core/routes/routes.dart';
import 'package:galaxyplay/modules/login/controller/login_controller.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class EntrarPage extends StatefulWidget {
  const EntrarPage({super.key});

  @override
  State<EntrarPage> createState() => _EntrarPageState();
}

class _EntrarPageState extends State<EntrarPage> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<AuthController>();
  final controllerUser = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagem ocupando a tela inteira
          Positioned.fill(
            child: Image.asset(
              'assets/images/galaxyfundo.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Container com bordas arredondadas sobrepondo a metade inferior da imagem
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: const BoxDecoration(
                color: Colors.white, // Cor de fundo do container
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              // Conteúdo do container aqui
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(Icons.arrow_back_ios)),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          )
                        ]),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controllerUser.emailController,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Campo vazio ou incorreto";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          controller: controllerUser.passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Senha',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Campo vazio ou incorreto";
                            }
                            return null;
                          }),
                    ),
                    const SizedBox(height: 24.0),
                    GetX<AuthController>(
                      builder: (loginController) {
                        return SizedBox(
                          width: 250,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            onPressed: loginController.isloading.value
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      await controller.login(
                                        email:
                                            controllerUser.emailController.text,
                                        password: controllerUser
                                            .passwordController.text,
                                      );

                                      controllerUser.emailController.clear();
                                      controllerUser.passwordController.clear();
                                      Get.toNamed(NamedRoutes.home);
                                    }
                                    Focus.of(context).unfocus();
                                  },
                            child: loginController.isloading.value
                                ? const CircularProgressIndicator()
                                : const Text('Entrar'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
