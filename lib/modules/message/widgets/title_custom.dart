// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TitleCustom extends StatelessWidget {
  final TextEditingController controller;
  final String titulo;
  final bool borde;
  const TitleCustom(
      {Key? key,
      required this.controller,
      required this.titulo,
      this.borde = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Campo obrigatório";
                }
                return null;
              },
              controller: controller,
              decoration: borde
                  ? const InputDecoration(hintText: "Adicione o nome do tópico")
                  : InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.transparent)),
        ],
      ),
    );
  }
}
