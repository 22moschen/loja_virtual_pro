import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_pro/models/user.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_pro/models/user.dart';

class FakeDocumentSnapshot implements DocumentSnapshot {
  final Map<String, dynamic> dataMap;
  final String docId;

  FakeDocumentSnapshot(this.docId, this.dataMap);

  @override
  Map<String, dynamic>? data() => dataMap;

  @override
  String get id => docId;

  @override
  // Implement other members with no-op or throw UnimplementedError if needed
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('User Model Tests', () {
    test('User constructor assigns fields correctly', () {
      final user = User(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        password: 'password',
        confirmPassword: 'password',
      );

      expect(user.id, '123');
      expect(user.name, 'Test User');
      expect(user.email, 'test@example.com');
      expect(user.password, 'password');
      expect(user.confirmPassword, 'password');
    });

    test('User.fromDocument creates User from DocumentSnapshot', () {
      final doc = FakeDocumentSnapshot('abc', {
        'name': 'Doc User',
        'email': 'docuser@example.com',
      });

      final user = User.fromDocument(doc);

      expect(user.id, 'abc');
      expect(user.name, 'Doc User');
      expect(user.email, 'docuser@example.com');
      expect(user.password, '');
      expect(user.confirmPassword, '');
    });

    test('toMap returns correct map', () {
      final user = User(
        id: '123',
        name: 'Map User',
        email: 'mapuser@example.com',
        password: 'password',
        confirmPassword: 'password',
      );

      final map = user.toMap();

      expect(map, {
        'name': 'Map User',
        'email': 'mapuser@example.com',
      });
    });
  });
}
