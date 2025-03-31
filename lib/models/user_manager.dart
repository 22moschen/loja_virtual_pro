import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/helpers/firebase_errors.dart';
import 'package:loja_virtual_pro/models/user.dart' as app_user;

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;
  firebase_auth.User? user;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> signIn({
    required app_user.User user,
    required Function(String) onFail,
    required Function(firebase_auth.User) onSuccess,
  }) async {
    loading = true;
    try {
      final firebase_auth.UserCredential result =
          await auth.signInWithEmailAndPassword(
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

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser() async {
    final firebase_auth.User? currentUser = auth.currentUser;
    if (currentUser != null) {
      user = currentUser;
      print(user!.uid);
    }
    notifyListeners();
  }
}
