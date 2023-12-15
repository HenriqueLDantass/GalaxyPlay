import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:galaxyplay/modules/home/models/home_model.dart';
import 'package:galaxyplay/modules/message/models/message_model.dart';
import 'package:galaxyplay/modules/videoPLay/model/videoplay_model.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<HomeModel> linkObs = [];

  Future<void> obterMessageTopics(String uid, int index) async {
    try {
      var userDocRef =
          FirebaseFirestore.instance.collection('usuarios').doc(uid);

      DocumentSnapshot userDoc = await userDocRef.get();

      if (userDoc.exists) {
        List<dynamic> messageTopics =
            userDoc['topics'][index]['messageTopics'] ?? [];

        linkObs.clear();
        linkObs.assignAll(messageTopics.map((messageTopic) {
          return HomeModel(
            uid: uid,
            title: userDoc['topics'][index]['title'] ?? "",
            description: userDoc['topics'][index]['description'] ?? "",
            videoTopics:
                (userDoc['topics'][index]['videoTopics'] as List<dynamic>)
                    .map((videoTopic) => VideoTopic(
                          link: videoTopic['link'] ?? "",
                        ))
                    .toList(),
            messageTopics: [
              MessageTopic(
                message: messageTopic['message'] ?? "",
                link: messageTopic['link'] ?? "",
                titulo: messageTopic['titulo'] ?? "",
              ),
            ],
            imagesPath: userDoc['topics'][index]['imagesPath'] ?? "",
          );
        }));

        update();
      } else {
        print('Usuário não encontrado para o ID: $uid');
      }
    } catch (e) {
      print('Erro ao obter dados do usuário: $e');
    }
  }

  void adicionarMensagemAoTopico(String uid, int index, String mensagem,
      String link, String titulo) async {
    try {
      var userData = await _firestore.collection('usuarios').doc(uid).get();

      if (userData.exists) {
        var topicsList =
            List<Map<String, dynamic>>.from(userData.data()!['topics'] ?? []);

        if (index >= 0 && index < topicsList.length) {
          var topic = topicsList[index];

          var messageTopics =
              List<Map<String, dynamic>>.from(topic['messageTopics'] ?? []);
          messageTopics.add({
            'message': mensagem,
            'link': link,
            'titulo': titulo,
          });

          topic['messageTopics'] = messageTopics;

          topicsList[index] = topic;

          await _firestore.collection('usuarios').doc(uid).update({
            'topics': topicsList,
          });

          await obterMessageTopics(uid, index);
        } else {
          print('Índice inválido: $index');
        }
      } else {
        print('Usuário não encontrado para o ID: $uid');
      }
    } catch (e) {
      print('Erro ao adicionar mensagem ao tópico: $e');
    }
    update();
  }

  void editarMensagemNoTopico(
      {required String uid,
      required int index,
      required int messageIndex,
      required String novaMensagem,
      required String novoLink,
      required String novoTitulo}) async {
    try {
      var userData = await _firestore.collection('usuarios').doc(uid).get();

      if (userData.exists) {
        var topicsList =
            List<Map<String, dynamic>>.from(userData.data()!['topics'] ?? []);

        if (index >= 0 && index < topicsList.length) {
          var topic = topicsList[index];

          var messageTopics =
              List<Map<String, dynamic>>.from(topic['messageTopics'] ?? []);

          if (messageIndex >= 0 && messageIndex < messageTopics.length) {
            var mensagemAtualizada = {
              'message': novaMensagem,
              'link': novoLink,
              'titulo': novoTitulo,
            };

            messageTopics[messageIndex] = mensagemAtualizada;

            topic['messageTopics'] = messageTopics;

            topicsList[index] = topic;

            await _firestore.collection('usuarios').doc(uid).update({
              'topics': topicsList,
            });

            await obterMessageTopics(uid, index);
          } else {
            print('Índice de mensagem inválido: $messageIndex');
          }
        } else {
          print('Índice de tópico inválido: $index');
        }
      } else {
        print('Usuário não encontrado para o ID: $uid');
      }
    } catch (e) {
      print('Erro ao editar mensagem no tópico: $e');
    }
    update();
  }

  void excluirMensagemDoTopico(String uid, int index, int messageIndex) async {
    try {
      var userData = await _firestore.collection('usuarios').doc(uid).get();

      if (userData.exists) {
        var topicsList =
            List<Map<String, dynamic>>.from(userData.data()!['topics'] ?? []);

        if (index >= 0 && index < topicsList.length) {
          var topic = topicsList[index];

          var messageTopics =
              List<Map<String, dynamic>>.from(topic['messageTopics'] ?? []);

          if (messageIndex >= 0 && messageIndex < messageTopics.length) {
            // Remove a mensagem no índice especificado
            messageTopics.removeAt(messageIndex);

            // Atualiza 'messageTopics' dentro do tópico específico
            topic['messageTopics'] = messageTopics;

            // Atualiza apenas o tópico específico, não todos os tópicos
            topicsList[index] = topic;

            await _firestore.collection('usuarios').doc(uid).update({
              'topics': topicsList,
            });

            await obterMessageTopics(uid, index);
          } else {
            print('Índice de mensagem inválido: $messageIndex');
          }
        } else {
          print('Índice de tópico inválido: $index');
        }
      } else {
        print('Usuário não encontrado para o ID: $uid');
      }
    } catch (e) {
      print('Erro ao excluir mensagem do tópico: $e');
    }
    update();
  }
}
