import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:galaxyplay/modules/home/models/home_model.dart';
import 'package:galaxyplay/modules/message/models/message_model.dart';
import 'package:galaxyplay/modules/videoPLay/model/videoplay_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  // final RemoteDatasource remoteDatasource = RemoteDatasource();

  RxList<HomeModel> cardlist = <HomeModel>[].obs;
  RxList<HomeModel> filterCards = <HomeModel>[].obs;

  //loding
  RxBool isloaging = false.obs;

  //controlles
  TextEditingController filterByName = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController mensagemController = TextEditingController();
  TextEditingController titulocontroller = TextEditingController();
  //FIREBASE
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //imagem
  File? imageFile;

  @override
  void onInit() {
    super.onInit();
    for (var homeModel in cardlist) {
      homeModel.videoTopics = <VideoTopic>[].obs;
    }
  }

  void adicionarTopicos(
      String titulo, String descricao, String image, String uid) async {
    try {
      setloagind(true);
      var userData = await _firestore.collection('usuarios').doc(uid).get();

      if (userData.exists && userData.data()!['topics'] != null) {
        await _firestore.collection('usuarios').doc(uid).update({
          'topics': FieldValue.arrayUnion([
            {
              'title': titulo,
              'description': descricao,
              'videoTopics': <VideoTopic>[].obs,
              'messageTopics': <MessageTopic>[].obs,
              'photoTopics': [],
              'imagesPath': imageFile != null ? imageFile!.path : "",
            }
          ]),
        });
      } else {
        await _firestore.collection('usuarios').doc(uid).set({
          'topics': [
            {
              'title': titulo,
              'description': descricao,
              'videoTopics': <VideoTopic>[].obs,
              'messageTopics': <MessageTopic>[].obs,
              'photoTopics': [],
              'imagesPath': imageFile != null ? imageFile!.path : "",
            }
          ],
        }, SetOptions(merge: true));
      }

      await carregarDados(uid);
      filtrarCards(filterByName.text);

      nameController.clear();
      descriptionController.clear();

      filterCards.assignAll(cardlist);
      setloagind(false);

      update();
    } catch (e) {
      print('Erro ao adicionar tópico: $e');
    }
  }

  Future<void> carregarDados(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _firestore.collection('usuarios').doc(id).get();

      if (documentSnapshot.exists) {
        cardlist.clear();

        if (documentSnapshot['topics'] != null) {
          for (var topic in documentSnapshot['topics']) {
            cardlist.add(HomeModel(
              uid: id,
              title: topic['title'],
              description: topic['description'],
              videoTopics: (topic['videoTopics'] as List<dynamic>)
                  .map((videoTopic) => VideoTopic(
                        link: videoTopic['link'] ?? '',
                      ))
                  .toList(),
              messageTopics: (topic['messageTopics'] as List<dynamic>)
                  .map((messageTopic) => MessageTopic(
                        message: messageTopic['messageTopics'] ?? "",
                        link: mensagemController.text,
                        titulo: titulocontroller.text,
                      ))
                  .toList(),
              imagesPath: topic['imagesPath'],
            ));
          }
        }

        cardlist.refresh();
        filterCards.assignAll(cardlist);
      } else {
        print('Documento não encontrado para o ID: $id');
      }
    } catch (e) {
      print('Erro ao carregar dados: $e');
    }
  }

  void editarTopico(String titulo, String descricao, String image, String uid,
      int index) async {
    try {
      var userData = await _firestore.collection('usuarios').doc(uid).get();

      if (userData.exists && userData.data()!['topics'] != null) {
        List<dynamic> topics = userData.data()!['topics'];
        topics[index] = {
          'title': titulo,
          'description': descricao,
          'videoTopics': <VideoTopic>[].obs,
          'messageTopics': <MessageTopic>[].obs,
          'photoTopics': [],
          'imagesPath': imageFile != null ? imageFile!.path : "",
        };

        await _firestore.collection('usuarios').doc(uid).update({
          'topics': topics,
        });

        await carregarDados(uid);
        filtrarCards(filterByName.text);
        filterCards.assignAll(cardlist);
        update();
      } else {
        print('Usuário ou tópicos não encontrados para o ID: $uid');
      }
    } catch (e) {
      print('Erro ao editar tópico: $e');
    }
  }

  Future<void> deletarTopico(String uid, int index) async {
    try {
      var userData = await _firestore.collection('usuarios').doc(uid).get();

      if (userData.exists && userData.data()!['topics'] != null) {
        List<dynamic> topics = userData.data()!['topics'];
        topics.removeAt(index);

        await _firestore.collection('usuarios').doc(uid).update({
          'topics': topics,
        });

        await carregarDados(uid);
        filtrarCards(filterByName.text);
        filterCards.assignAll(cardlist);
        update();
      } else {
        print('Usuário ou tópicos não encontrados para o ID: $uid');
      }
    } catch (e) {
      print('Erro ao deletar tópico: $e');
    }
  }

  void filtrarCards(String filtro) {
    filterCards.clear();
    filterCards.addAll(cardlist.where((homeModel) =>
        homeModel.title.toLowerCase().contains(filtro.toLowerCase()) ||
        homeModel.description.toLowerCase().contains(filtro.toLowerCase())));
    filterCards.refresh();
    update();
  }

//capturar imagem
  Future<void> pickImage(ImageSource sorce) async {
    final pickerFiler = await ImagePicker().pickImage(source: sorce);
    if (pickerFiler != null) {
      imageFile = File(pickerFiler.path);
      for (var homeModel in cardlist) {
        homeModel.imagesPath = imageFile!.path;
      }
      update();
    }
  }

  void setloagind(bool value) {
    isloaging.value = value;
    update();
  }
}
