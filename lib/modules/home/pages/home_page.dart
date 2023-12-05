import 'package:flutter/material.dart';
import 'package:galaxyplay/modules/home/controller/home_controller.dart';
import 'package:galaxyplay/modules/home/models/home_model.dart';
import 'package:galaxyplay/modules/home/widgets/drawer_custom.dart';
import 'package:galaxyplay/modules/home/widgets/text_form_custom.dart';
import 'package:galaxyplay/modules/home/widgets/topico_item_widget.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerCustomWidget(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //navegacao drawer
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

            //pesquisa
            TextFormFieldCustom(
              controller: controller.filterByName,
              text: "Digite o topico",
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
                    "Topicos",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                    onPressed: () => _dialogBuilder(context),
                    child: const Text("+ Add topico"))
              ],
            ),
            //cards
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Obx(() => ListView.builder(
                    scrollDirection:
                        Axis.horizontal, // Configura o scroll horizontal
                    itemCount: controller.filterCards.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.off(TopicoItem(
                            home: controller.filterCards,
                            index: index,
                          ));
                        },
                        child: Card(
                            child: Column(children: [
                          Text(
                            controller.filterCards[index].title,
                            style: const TextStyle(fontSize: 50),
                          ),
                          Text(controller.filterCards[index].description),
                        ])),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Preencha os campos para adicionar o novo topico"),
          actions: [
            TextField(
              controller: controller.nameController,
            ),
            TextField(
              controller: controller.descriptionController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Criar'),
                  onPressed: () {
                    controller.adicionarTopicos(HomeModel(
                        title: controller.nameController.text,
                        description: controller.descriptionController.text));
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
}
