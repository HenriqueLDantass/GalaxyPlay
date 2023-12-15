// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HomeModel {
  final String uid;
  final String title;
  final String description;
  List<VideoTopic> videoTopics;
  final List<MessageTopic> messageTopics;
  String imagesPath;

  HomeModel(
      {required this.uid,
      required this.title,
      required this.description,
      required this.videoTopics,
      required this.messageTopics,
      required this.imagesPath});
}

class VideoTopic {
  final String link;

  VideoTopic({required this.link});
}

class MessageTopic {
  final String message;
  final String link;
  final String titulo;
  MessageTopic({
    required this.titulo,
    required this.message,
    required this.link,
  });

  // Adicione este método toJson
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'link': link,
      'titulo': titulo,
    };
  }
}
