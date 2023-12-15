import 'package:flutter/cupertino.dart';

class SemCadastro extends StatelessWidget {
  const SemCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("Nao tem nenhum topico cadastrado"),
        // Expanded(
        //   child: Image.asset("assets/images/nada.png"),
        // ),
      ],
    );
  }
}
