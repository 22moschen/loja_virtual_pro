import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/helpers/firebase_errors.dart';
import 'package:loja_virtual_pro/models/user.dart' as app_user;
import 'package:cloud_firestore/cloud_firestore.dart';

class UserManager extends ChangeNotifier {
  final firebase_auth.FirebaseAuth auth;
  final FirebaseFirestore firestore;

  app_user.User? user;

  bool _loading = false;
  bool get loading => _loading;

  UserManager({
    firebase_auth.FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : auth = auth ?? firebase_auth.FirebaseAuth.instance,
        firestore = firestore ?? FirebaseFirestore.instance {
    _loadCurrentUser(null);
  }

  Future<void> signIn({
    required app_user.User user,
    required Function(String) onFail,
    required Function(firebase_auth.User) onSuccess,
  }) async {
    loading = true;
    try {
      final firebase_auth.UserCredential result = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      this.user = user;
      print('Usuário logado: ${user.name}');
      onSuccess(result.user!);
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

      user.id = result.user!.uid;

      await user.saveData();

      print('Usuário cadastrado: ${user.name}');
      onSuccess();
    } on firebase_auth.FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser(firebase_auth.User? firebaseUser) async {
    final firebase_auth.User? currentUser = firebaseUser ?? auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser = await firestore.collection('users').doc(currentUser.uid).get();
      user = app_user.User.fromDocument(docUser);
      print('Usuário carregado: ${user?.name}');
      notifyListeners();
    }
  }

  // Public method to allow testing user loading
  Future<void> loadCurrentUser(firebase_auth.User? firebaseUser) async {
    await _loadCurrentUser(firebaseUser);
  }
}
