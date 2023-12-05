import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final bool icone;
  final String text;
  final void Function(String)? onChanged;
  const TextFormFieldCustom(
      {super.key,
      required this.controller,
      this.icone = true,
      required this.text,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          filled: true,
          fillColor: Colors.grey[200], // Cor de fundo do campo de texto
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Borda arredondada
            borderSide: BorderSide.none, // Sem borda ao redor do campo
          ),
          prefixIcon: !icone
              ? null
              : Icon(
                  Icons.search,
                  color: Colors.grey[600], // Cor do ícone
                ),
        ),
      ),
    );
  }
}
