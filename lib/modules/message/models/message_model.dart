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
