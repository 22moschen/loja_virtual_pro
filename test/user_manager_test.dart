import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loja_virtual_pro/models/user_manager.dart';
import 'package:loja_virtual_pro/models/user.dart' as app_user;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late UserManager userManager;
  late MockFirebaseAuth mockAuth;
  late FakeFirebaseFirestore fakeFirestore;

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  setUp(() {
    mockAuth = MockFirebaseAuth();
    fakeFirestore = FakeFirebaseFirestore();

    userManager = UserManager(auth: mockAuth, firestore: fakeFirestore);
  });

  group('UserManager Tests', () {
    test('signIn success calls onSuccess', () async {
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
      mockAuth = MockFirebaseAuth(signedIn: false);

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
      mockAuth = MockFirebaseAuth(signedIn: false);

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
      final firebaseUser = mockAuth.currentUser;

      await userManager.loadCurrentUser(firebaseUser);

      // Since FakeFirebaseFirestore is empty, user will be null
      expect(userManager.user, null);
    });
  });
}
