import 'package:flutter/material.dart';
import 'package:galaxyplay/core/Auth/repository/auth_reposity.dart';
import 'package:galaxyplay/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:galaxyplay/core/Auth/model/auth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository = AuthRepository();
  var usuarioList = Rxn<AuthModel>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  HomeController homeController = Get.find<HomeController>();
  RxBool isloading = false.obs;

  @override
  void onInit() {
    super.onInit();

    ever(usuarioList, (AuthModel? usuario) {
      if (usuario != null) {
        homeController.carregarDados(usuario.uid);
      }
    });
  }

  void setLoding(bool loading) {
    isloading.value = loading;
    update();
  }

// //LOGIN certo
  Future<AuthModel?> login(
      {required String email, required String password}) async {
    try {
      setLoding(true);
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      AuthModel? usuario =
          await authRepository.getUsuarioFromFirestore(credential.user!.uid);
      usuarioList.value = usuario;
      update();
      setLoding(false);

      return usuario;
    } catch (e) {
      print("Aconteceu um erro: $e");
      return null;
    }
  }

  Future<void> mostrarDialogEmailExistente() async {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Email Existente'),
          content: const Text(
              'Este email já está cadastrado. Por favor, escolha outro.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> verificarEmailExistente(String email) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      mostrarDialogEmailExistente();
      print('O email já está cadastrado.');
      throw Exception(
          'Email já cadastrado'); // Lança uma exceção para interromper o fluxo
    }
  }

  Future<AuthModel?> criarUsuario({
    required String email,
    required String password,
    required String nome,
    required int idade,
  }) async {
    try {
      await verificarEmailExistente(email);
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = credential.user;

      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user!.uid)
          .set(AuthModel(
            uid: user.uid,
            nome: nome,
            email: email,
            idade: idade,
          ).toMap());

      AuthModel usuario = AuthModel(
        uid: user.uid,
        nome: nome,
        email: email,
        idade: idade,
      );

      AuthModel? usuariob =
          await authRepository.getUsuarioFromFirestore(credential.user!.uid);
      if (usuariob != null) {
        print("Usuário autenticado: ${credential.user?.uid}");
        return usuario;
      } else {
        return null;
      }
    }

    //userController.setUsuario(usuario);
    catch (e) {}
    return null;
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      usuarioList.value = null;
    } catch (e) {
      print(e);
    }
  }
}
