class AuthModel {
  String uid;
  String nome = "";
  String email;
  int idade;

  AuthModel({
    required this.uid,
    required this.nome,
    required this.email,
    required this.idade,
  });

  // Função para converter AuthModel para um mapa (para salvar no Firestore)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nome': nome,
      'email': email,
      'idade': idade,
    };
  }

  // Função estática para criar uma instância de AuthModel a partir de um mapa (do Firestore)
  static AuthModel fromMap(Map<String, dynamic> map) {
    return AuthModel(
      uid: map['uid'] ?? '',
      nome: map['nome'] ?? '',
      idade: map['idade'] ?? 0,
      email: map['email'] ?? '',
    );
  }
}
