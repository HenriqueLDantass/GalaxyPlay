import 'package:flutter/cupertino.dart';

class SemCadastro extends StatelessWidget {
  const SemCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Você não possuí nenhum tópico cadastrado!",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Image.asset("assets/images/person.png"),
        ),
      ],
    );
  }
}
