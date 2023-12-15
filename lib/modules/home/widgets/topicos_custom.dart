import 'dart:io';

import 'package:flutter/material.dart';
import 'package:galaxyplay/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';

class TopicosCard extends StatelessWidget {
  final String name;
  final String description;
  final String image;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final String uid;
  final int index;

  const TopicosCard({
    super.key,
    required this.name,
    required this.description,
    required this.image,
    required this.onEdit,
    required this.onDelete,
    required this.uid,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 500,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft:
                Radius.circular(10.0), // Raio do canto inferior esquerdo
            bottomRight:
                Radius.circular(10.0), // Raio do canto inferior direito
          ),
        ),
        elevation: 5,
        child: GetBuilder<HomeController>(
          builder: (controller) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    color: Colors.black,
                  ),
                ),
                controller.imageFile == null
                    ? Container()
                    : Image.file(File(image)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          name,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        _showPopupMenu(context);
                      },
                    ),
                  ],
                ),
                const Divider(),
                Text(description),
                // Add the IconButton with three dots
              ],
            );
          },
        ),
      ),
    );
  }

  void _showPopupMenu(BuildContext context) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        PopupMenuItem(
          child: GetBuilder<HomeController>(
            builder: (controller) {
              return GestureDetector(
                onDoubleTap: () => _handleEdit(
                  context,
                  controller.nameController.text,
                  controller.descriptionController.text,
                  image,
                ),
                child: ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Editar'),
                  onTap: () {
                    onEdit();
                  },
                ),
              );
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () {
              onDelete();
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  void _handleEdit(
    BuildContext context,
    String initialName,
    String initialDescription,
    String initialImage,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: GetBuilder<HomeController>(
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Editar Detalhes'),
                  TextFormField(
                    controller: controller.nameController,
                    decoration: const InputDecoration(labelText: 'Novo Nome'),
                  ),
                  TextFormField(
                    controller: controller.descriptionController,
                    decoration:
                        const InputDecoration(labelText: 'Novo Descrição'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.editarTopico(
                        controller.nameController.text,
                        controller.descriptionController.text,
                        initialImage, // Passe o caminho da imagem original
                        uid,
                        index,
                      );

                      Navigator.pop(context); // Feche o modal
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
