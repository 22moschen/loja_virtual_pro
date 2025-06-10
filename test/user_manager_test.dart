import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_pro/models/user_manager.dart';
import 'package:loja_virtual_pro/models/user.dart' as app_user;

import 'user_manager_test.mocks.dart';

@GenerateMocks([
  firebase_auth.FirebaseAuth,
  firebase_auth.UserCredential,
  firebase_auth.User,
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  DocumentSnapshot,
])
void main() {
  late UserManager userManager;
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockFirestore;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore();
    userManager = UserManager(auth: mockAuth, firestore: mockFirestore);
  });

  group('UserManager Tests', () {
    test('signIn success calls onSuccess', () async {
      final mockUser = MockUser();
      final mockUserCredential = MockUserCredential();

      when(mockAuth.signInWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);

      final user = app_user.User(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        password: 'password',
        confirmPassword: 'password',
      );

      var onSuccessCalled = false;
      var onFailCalled = false;

      await userManager.signIn(
        user: user,
        onFail: (msg) => onFailCalled = true,
        onSuccess: (firebaseUser) => onSuccessCalled = true,
      );

      expect(onSuccessCalled, true);
      expect(onFailCalled, false);
    });

    test('signIn failure calls onFail', () async {
      when(mockAuth.signInWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password')))
          .thenThrow(firebase_auth.FirebaseAuthException(code: 'user-not-found'));

      final user = app_user.User(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
        password: 'password',
        confirmPassword: 'password',
      );

      var onSuccessCalled = false;
      var onFailCalled = false;

      await userManager.signIn(
        user: user,
        onFail: (msg) => onFailCalled = true,
        onSuccess: (firebaseUser) => onSuccessCalled = true,
      );

      expect(onSuccessCalled, false);
      expect(onFailCalled, true);
    });

    test('signUp success calls onSuccess', () async {
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();

      when(mockAuth.createUserWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('123');

      final user = app_user.User(
        id: '',
        name: 'Test User',
        email: 'test@example.com',
        password: 'password',
        confirmPassword: 'password',
      );

      var onSuccessCalled = false;
      var onFailCalled = false;

      await userManager.signUp(
        user: user,
        onFail: (msg) => onFailCalled = true,
        onSuccess: () => onSuccessCalled = true,
      );

      expect(onSuccessCalled, true);
      expect(onFailCalled, false);
    });

    test('signUp failure calls onFail', () async {
      when(mockAuth.createUserWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password')))
          .thenThrow(firebase_auth.FirebaseAuthException(code: 'email-already-in-use'));

      final user = app_user.User(
        id: '',
        name: 'Test User',
        email: 'test@example.com',
        password: 'password',
        confirmPassword: 'password',
      );

      var onSuccessCalled = false;
      var onFailCalled = false;

      await userManager.signUp(
        user: user,
        onFail: (msg) => onFailCalled = true,
        onSuccess: () => onSuccessCalled = true,
      );

      expect(onSuccessCalled, false);
      expect(onFailCalled, true);
    });

    test('loadCurrentUser loads user and notifies listeners', () async {
      final mockDocSnapshot = MockDocumentSnapshot();
      final mockCollection = MockCollectionReference();
      final mockDocRef = MockDocumentReference();

      when(mockFirestore.collection('users')).thenReturn(mockCollection as CollectionReference<Map<String, dynamic>>);
      when(mockCollection.doc(any)).thenReturn(mockDocRef);
      when(mockDocRef.get()).thenAnswer((_) async => mockDocSnapshot);
      when(mockDocSnapshot.exists).thenReturn(true);
      when(mockDocSnapshot.data()).thenReturn({
        'name': 'Test User',
        'email': 'test@example.com',
      });

      final firebaseUser = MockUser();
      when(firebaseUser.uid).thenReturn('123');

      await userManager.loadCurrentUser(firebaseUser);

      expect(userManager.user?.name, 'Test User');
    });
  });
}
