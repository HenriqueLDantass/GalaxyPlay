import 'package:flutter/material.dart';
import 'package:galaxyplay/modules/login/pages/entrar_page.dart';

class CriarContaPage extends StatefulWidget {
  const CriarContaPage({super.key});

  @override
  State<CriarContaPage> createState() => _CriarContaPageState();
}

class _CriarContaPageState extends State<CriarContaPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _isEmailValid = true;

  bool _isPasswordValid = true;

  void _validateEmail(String email) {
    setState(() {
      _isEmailValid = email.isNotEmpty;
    });
  }

  void _validatePassword(String password) {
    setState(() {
      _isPasswordValid = password.isNotEmpty;
    });
  }

  void _login() {
    if (_isEmailValid && _isPasswordValid) {
      // Lógica de autenticação
      // Aqui você pode adicionar a lógica para autenticar o usuário
      print('E-mail: ${_emailController.text}');
      print('Senha: ${_passwordController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              onChanged: _validateEmail,
              decoration: InputDecoration(
                labelText: 'E-mail',
                errorText: _isEmailValid ? null : 'Digite um e-mail válido',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              onChanged: _validatePassword,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                errorText: _isPasswordValid ? null : 'Digite uma senha válida',
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Entrar'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const EntrarPage()));
                },
                child: const Text("Clique aqui para realizar o login!"))
          ],
        ),
      ),
    );
  }
}
