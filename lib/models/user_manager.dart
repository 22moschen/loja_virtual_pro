import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/helpers/firebase_errors.dart';
//import 'package:flutter/services.dart';
import 'package:loja_virtual_pro/models/user.dart' as app_user;

class UserManager extends ChangeNotifier {
  final firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;

  bool loading = false;

  Future<void> signIn({
    required app_user.User user, // Marcar como required
    required Function(String)
    onFail, // Marcar como required e especificar tipo do parâmetro (String)
    required Function(firebase_auth.User)
    onSuccess, // Marcar como required e especificar tipo do parâmetro (firebase_auth.User)
  }) async {
    setLoading(true);
    try {
      final firebase_auth.UserCredential result = await auth
          .signInWithEmailAndPassword(
            email: user.email,
            password: user.password,
          );
    } on firebase_auth.FirebaseAuthException catch (e) {
      // Exibe a mensagem de erro recebida do Firebase.
      onFail(getErrorString(e.code));
    }
    setLoading(false);
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    super.notifyListeners(); // Notificar os listeners
  }
}
