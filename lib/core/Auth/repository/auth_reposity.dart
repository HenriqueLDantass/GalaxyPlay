import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:galaxyplay/core/Auth/model/auth_model.dart';

class AuthRepository {
  Future<AuthModel?> getUsuarioFromFirestore(String uid) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(uid)
          .get();

      if (snapshot.exists) {
        AuthModel usuario =
            AuthModel.fromMap(snapshot.data() as Map<String, dynamic>);
        print("Usuario encontrado");
        print('UID: ${usuario.uid}');
        print('Name: ${usuario.nome}');
        print('Email: ${usuario.email}');
        // userController.setUsuario(usuario);

        return usuario;
      } else {
        print('Usuário não encontrado no Firestore.');
        return null;
      }
    } catch (e) {
      print('Erro ao obter usuário do Firestore: $e');
      return null;
    }
  }
}
