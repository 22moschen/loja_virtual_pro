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
    const MethodChannel channel = MethodChannel('plugins.flutter.io/firebase_core');

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        if (methodCall.method == 'Firebase#initializeCore' || methodCall.method == 'Firebase#initializeApp') {
          return <String, dynamic>{
            'name': '[DEFAULT]',
            'options': <String, dynamic>{},
            'pluginConstants': <String, dynamic>{},
          };
        }
        return null;
      },
    );

    // Inicializa mocks do Firebase Auth e Firestore
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirestore = FakeFirebaseFirestore();

    await Firebase.initializeApp();
  });
}
