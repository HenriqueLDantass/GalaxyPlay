import 'package:flutter/material.dart';
import 'package:galaxyplay/modules/home/controller/home_controller.dart';
import 'package:galaxyplay/modules/home/models/home_model.dart';
import 'package:galaxyplay/modules/message/controller/message_controller.dart';
import 'package:galaxyplay/modules/videoPLay/pages/video_play_page.dart';
import 'package:get/get.dart';

//MUDAR DE PASTA
class TopicoItem extends StatelessWidget {
  final RxList<HomeModel> home;
  final int index;
  final String uid;
  TopicoItem(
      {super.key, required this.home, required this.index, required this.uid});

  final messageController = Get.find<MessageController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(home[index].title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _dialogBuilder(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(children: [
        Column(
          children: [
            SizedBox(
              width: 500,
              height: 500,
              child: GetBuilder<MessageController>(
                builder: (controller) {
                  return controller.linkObs.isEmpty
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Voce não adicinou nenhum link!",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.link_off,
                              size: 50,
                            )
                          ],
                        )
                      : ListView.builder(
                          itemCount: controller.linkObs.length,
                          itemBuilder: (context, linkIndex) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => VideoPlayerScreen(
                                      title:
                                          controller.linkObs[linkIndex].title,
                                      linkVideo: controller.linkObs[linkIndex]
                                          .messageTopics[0].link,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller.linkObs[linkIndex]
                                              .messageTopics[0].titulo,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.more_vert),
                                          onPressed: () {
                                            _showPopupMenu(context, linkIndex);
                                          },
                                        ),
                                      ],
                                    ),
                                    Text(controller.linkObs[linkIndex]
                                        .messageTopics[0].message),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return _buildAlertDialog(context);
      },
    );
  }

  Widget _buildAlertDialog(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 24, right: 24),
          title: const Text("Adicione itens para o topico"),
          actions: [
            const Text("Adicione o titulo"),
            TextField(
              controller: controller.titulocontroller,
            ),
            const Text("Adicione o link"),
            TextField(
              controller: controller.linkController,
            ),
            const Text("Adicione a mensagem"),
            TextField(
              controller: controller.mensagemController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Adicionar Link'),
                  onPressed: () {
                    messageController.adicionarMensagemAoTopico(
                        uid,
                        index,
                        controller.mensagemController.text,
                        controller.linkController.text,
                        controller.titulocontroller.text);
                    controller.carregarDados(uid);

                    controller.mensagemController.clear();
                    controller.linkController.clear();
                    controller.titulocontroller.clear();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  void _showPopupMenu(BuildContext context, int indexMessage) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        PopupMenuItem(
          child: GetBuilder<HomeController>(
            builder: (controller) {
              return GestureDetector(
                onDoubleTap: () {
                  _handleEdit(context);
                },
                child: ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Editar'),
                  onTap: () {
                    messageController.editarMensagemNoTopico(
                        messageIndex: indexMessage,
                        uid: uid,
                        index: index,
                        novaMensagem: controller.mensagemController.text,
                        novoTitulo: controller.titulocontroller.text,
                        novoLink: controller.linkController.text);
                    Navigator.pop(context);
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
              messageController.excluirMensagemDoTopico(
                  uid, index, indexMessage);
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  void _handleEdit(
    BuildContext context,
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
                    controller: controller.titulocontroller,
                    decoration: const InputDecoration(labelText: 'Novo titulo'),
                  ),
                  TextFormField(
                    controller: controller.linkController,
                    decoration: const InputDecoration(labelText: 'Novo link'),
                  ),
                  TextFormField(
                    controller: controller.mensagemController,
                    decoration:
                        const InputDecoration(labelText: 'Nova mensagem'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      messageController.editarMensagemNoTopico(
                          uid: uid,
                          index: index,
                          messageIndex: index,
                          novaMensagem: controller.mensagemController.text,
                          novoLink: controller.linkController.text,
                          novoTitulo: controller.titulocontroller.text);

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
