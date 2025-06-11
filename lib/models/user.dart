import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  late String id;
  late String name;
  late String email;
  late String password;
  late String confirmPassword;

  User({
    required this.email,
    required this.password,
    required this.name,
    required this.confirmPassword,
    required this.id,
  });

  User.fromDocument(dynamic document) {
    id = document.id;
    final data = document.data() as Map<String, dynamic>;
    name = data['name'] as String;
    email = data['email'] as String;
    password = '';
    confirmPassword = '';
  }

  Future<void> saveData() async {
    await FirebaseFirestore.instance.collection('users').doc(id).set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
