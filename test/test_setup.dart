import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

late MockFirebaseAuth mockFirebaseAuth;
late FakeFirebaseFirestore mockFirestore;

void setupFirebaseMocks() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    const MethodChannel firebaseCoreChannel = MethodChannel(
      'plugins.flutter.io/firebase_core',
    );
    const MethodChannel firebaseAuthChannel = MethodChannel(
      'plugins.flutter.io/firebase_auth',
    );
    const MethodChannel firestoreChannel = MethodChannel(
      'plugins.flutter.io/cloud_firestore',
    );

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(firebaseCoreChannel, (
          MethodCall methodCall,
        ) async {
          if (methodCall.method == 'Firebase#initializeCore' ||
              methodCall.method == 'Firebase#initializeApp') {
            return <String, dynamic>{
              'name': '[DEFAULT]',
              'options': <String, dynamic>{},
              'pluginConstants': <String, dynamic>{},
            };
          }
          return null;
        });

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(firebaseAuthChannel, (
          MethodCall methodCall,
        ) async {
          // Add any necessary mock responses for Firebase Auth methods here
          return null;
        });

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(firestoreChannel, (
          MethodCall methodCall,
        ) async {
          // Add any necessary mock responses for Firestore methods here
          return null;
        });

    // Inicializa mocks do Firebase Auth e Firestore
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirestore = FakeFirebaseFirestore();

    // Condicional para evitar PlatformException em testes locais no Dart VM
    if (!kIsWeb && (Platform.isLinux || Platform.isMacOS || Platform.isWindows)) {
      // Não inicializa Firebase real em testes locais para evitar erros
      return;
    }

    await Firebase.initializeApp();
  });
}
