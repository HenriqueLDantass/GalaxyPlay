import 'package:flutter/material.dart';
import 'package:galaxyplay/modules/home/models/home_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<HomeModel> cardlist = <HomeModel>[].obs;
  RxList<HomeModel> filterCards = <HomeModel>[].obs;

  TextEditingController filterByName = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void adicionarTopicos(HomeModel cardItem) {
    cardlist.add(cardItem);
    filtrarCards(filterByName.text);
    nameController.clear();
    descriptionController.clear();
    print("adicionado com sucesso!");
  }

  void filtrarCards(String termo) {
    filterCards.assignAll(cardlist.where((card) {
      return card.title.toLowerCase().contains(termo.toLowerCase()) ||
          card.description.toLowerCase().contains(termo.toLowerCase());
    }));
    update();
  }
}
