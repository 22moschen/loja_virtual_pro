import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseApp extends Mock implements FirebaseApp {}

void setupFirebaseMocks() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Mock Firebase.initializeApp to return a mocked FirebaseApp
    when(Firebase.initializeApp()).thenAnswer((_) async => MockFirebaseApp());
  });
}
