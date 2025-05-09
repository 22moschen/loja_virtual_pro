

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/helpers/firebase_errors.dart';
import 'package:loja_virtual_pro/models/user.dart' as app_user;

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser(); // essa função privada, vai carregar o usuário
  }

  final firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;
  firebase_auth.User? user;

  bool _loading = false; // criando variavel privada com ( _ ).
  bool get loading => _loading; // expondo a variavel atráves de um ( get ).
  // essa variável _loading verifica se a página está
  //carregando atráves de um valor booleano
  Future<void> signIn({
    required app_user.User user,
    required Function(String) onFail,
    required Function(firebase_auth.User) onSuccess,
  }) async {
    loading = true;
    try {
      final firebase_auth.UserCredential result = await auth
          .signInWithEmailAndPassword(
            email: user.email,
            password: user.password,
          );

      this.user = result.user;
      onSuccess(this.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> sigunUp({
    required app_user.User user, 
    required Function(String) onFail,
    required Function() onSuccess,
    }) async {
      loading = true;
    try {
      final firebase_auth.UserCredential result = await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      this.user = result.user;

      onSuccess();
    } on firebase_auth.FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  set loading(bool value) {
    // setando a variavel atraves de um ( set )
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser() async {
    final firebase_auth.User? currentUser = auth.currentUser;
    if (currentUser != null) {
      // se meu usuário atual for diferente de nulo...
      user = currentUser;
      debugPrint(user!.uid);
    }
    notifyListeners();
  }
}
