import 'package:flutter/material.dart';
import 'package:galaxyplay/core/Auth/controller/auth_controller.dart';
import 'package:galaxyplay/core/Auth/model/auth_model.dart';

import 'package:galaxyplay/modules/home/controller/home_controller.dart';
import 'package:galaxyplay/modules/home/models/home_model.dart';
import 'package:galaxyplay/modules/home/widgets/drawer_custom.dart';
import 'package:galaxyplay/modules/home/widgets/sem_cadastro.dart';
import 'package:galaxyplay/modules/home/widgets/text_form_custom.dart';
import 'package:galaxyplay/modules/message/pages/message_page.dart';
import 'package:galaxyplay/modules/home/widgets/topicos_custom.dart';
import 'package:galaxyplay/modules/message/controller/message_controller.dart';
import 'package:galaxyplay/modules/message/widgets/title_custom.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.find<HomeController>();
  final MessageController messageController = Get.find<MessageController>();

  final authController =
      Get.find<AuthController>(); // Obtenha a instância do AuthController
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        drawer: const DrawerCustomWidget(),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.carregarDados(authController.usuarioList.value!.uid);

            controller.filtrarCards(controller.filterByName.text);
          },
          child: ListView(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                //navegacao drawer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          size: 40,
                        ),
                      ),
                    ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            const Text("Bem vindo,"),
                            Text(
                              authController.usuarioList.value!.nome,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),

                //pesquisa
                TextFormFieldCustom(
                  controller: controller.filterByName,
                  text: "Digite o tópico",
                  onChanged: (value) {
                    controller.filtrarCards(value);
                  },
                ),

                //titulo + add card
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Tópicos",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          _dialogBuilder(context);
                          controller.carregarDados(
                              authController.usuarioList.value!.uid);
                        },
                        child: const Text("+ Add tópico"))
                  ],
                ),

                //cards

                GetBuilder<HomeController>(
                  builder: (homeController) {
                    return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 400,
                        child: controller.cardlist.isEmpty
                            ? const SemCadastro()
                            : controller.isloaging.value
                                ? const SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: CircularProgressIndicator())
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.filterCards.isNotEmpty
                                        ? controller.filterCards.length
                                        : controller.cardlist.length,
                                    itemBuilder: (context, index) {
                                      final HomeModel currentItem =
                                          controller.filterCards.isNotEmpty
                                              ? controller.filterCards[index]
                                              : controller.cardlist[index];

                                      return GestureDetector(
                                        onTap: () {
                                          messageController.obterMessageTopics(
                                              authController
                                                  .usuarioList.value!.uid,
                                              index);
                                          Get.to(TopicoItem(
                                            uid: authController
                                                .usuarioList.value!.uid,
                                            home: controller.cardlist,
                                            index: index,
                                          ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6.0),
                                          child: TopicosCard(
                                            name: currentItem.title,
                                            description:
                                                currentItem.description,
                                            image: currentItem.imagesPath,
                                            onEdit: () {},
                                            onDelete: () async {
                                              await controller.deletarTopico(
                                                authController
                                                    .usuarioList.value!.uid,
                                                index,
                                              );
                                            },
                                            uid: authController
                                                .usuarioList.value!.uid,
                                            index: index,
                                          ),
                                        ),
                                      );
                                    },
                                  ));
                  },
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  //Modal para criar topico
  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Preencha os campos para adicionar o novo tópico!"),
          actions: [
            TitleCustom(
                borde: true,
                controller: controller.nameController,
                titulo: "Título do tópico"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Descrição do tópico: *opcional",
                ),
                controller: controller.descriptionController,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  onPressed: () {
                    controller.nameController.clear();
                    controller.descriptionController.clear();

                    Get.back();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text(
                    'Criar',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  onPressed: () {
                    AuthModel usuario = authController.usuarioList.value!;

                    controller.adicionarTopicos(
                      controller.nameController.text,
                      controller.descriptionController.text,
                      controller.imageFile.toString(),
                      usuario.uid,
                    );
                    controller.nameController.clear();
                    controller.descriptionController.clear();
                    controller
                        .carregarDados(authController.usuarioList.value!.uid);
                    Get.back();
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
