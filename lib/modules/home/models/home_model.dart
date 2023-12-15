// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:galaxyplay/modules/message/models/message_model.dart';
import 'package:galaxyplay/modules/videoPLay/model/videoplay_model.dart';

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
