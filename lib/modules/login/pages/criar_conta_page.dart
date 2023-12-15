import 'package:flutter/material.dart';
import 'package:galaxyplay/core/Auth/repository/auth_reposity.dart';
import 'package:galaxyplay/core/Auth/controller/auth_controller.dart';
import 'package:galaxyplay/core/Auth/model/auth_model.dart';
import 'package:galaxyplay/core/routes/routes.dart';
import 'package:galaxyplay/modules/login/pages/entrar_page.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class CriarContaPage extends StatefulWidget {
  const CriarContaPage({super.key});

  @override
  State<CriarContaPage> createState() => _CriarContaPageState();
}

class _CriarContaPageState extends State<CriarContaPage> {
  final controller = Get.find<AuthController>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Erro ao cadastrar o email";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Erro ao cadastrar o senha";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _nomeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Erro ao cadastrar o nome";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _idadeController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Erro ao cadastrar a idade";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Idade',
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _mostrarModal(context);
                    controller.criarUsuario(
                        email: _emailController.text,
                        password: _passwordController.text,
                        nome: _nomeController.text,
                        idade: 2);
                  }
                },
                child: const Text('Criar Usuário'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 300, // Ajuste o valor conforme necessário
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Conta criada com sucesso!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: RiveAnimation.network(
                        "https://public.rive.app/community/runtime-files/1610-3160-check-trade.riv"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.offNamed(NamedRoutes.signRoute);
                        },
                        child: const Text("Login"),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Fechar"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
