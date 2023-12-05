import 'package:flutter/material.dart';
import 'package:galaxyplay/modules/home/pages/home_page.dart';

class EntrarPage extends StatefulWidget {
  const EntrarPage({super.key});

  @override
  State<EntrarPage> createState() => _EntrarPageState();
}

class _EntrarPageState extends State<EntrarPage> {
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

      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HomePage()));
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
          ],
        ),
      ),
    );
  }
}
