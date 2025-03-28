import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
//import 'package:flutter/services.dart';
import 'package:loja_virtual_pro/models/user.dart' as app_user;

class UserManager {
  final firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;

  Future<void> singIn(app_user.User user) async {
    try {
      final firebase_auth.UserCredential result =
          await auth.signInWithEmailAndPassword(
              email: user.email, password: user.password);
      // Evite usar print em produção; use um framework de logging.
      print(result.user?.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      // Exibe a mensagem de erro recebida do Firebase.
      print(e.message);
    }
  }
}
