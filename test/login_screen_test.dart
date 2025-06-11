import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loja_virtual_pro/screens/login/login_screen.dart';
import 'package:loja_virtual_pro/models/user_manager.dart';
import 'package:loja_virtual_pro/models/user.dart' as app_user;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockUserManager extends ChangeNotifier implements UserManager {
  bool _loading = false;
  @override
  bool get loading => _loading;

  app_user.User? _user;
  @override
  app_user.User? get user => _user;
  @override
  set user(app_user.User? value) {
    _user = value;
  }

  bool signInCalled = false;
  String? emailPassed;
  String? passwordPassed;

  @override
  Future<void> signIn({
    required app_user.User user,
    required Function(String) onFail,
    required Function(firebase_auth.User) onSuccess,
  }) async {
    signInCalled = true;
    emailPassed = user.email;
    passwordPassed = user.password;
    onSuccess(MockFirebaseUser());
  }

  @override
  Future<void> signUp({
    required app_user.User user,
    required Function(String) onFail,
    required Function() onSuccess,
  }) async {
    // Mock implementation
    onSuccess();
  }

  @override
  Future<void> loadCurrentUser(firebase_auth.User? firebaseUser) async {
    // Mock implementation
  }

  @override
  firebase_auth.FirebaseAuth get auth => throw UnimplementedError();

  @override
  FirebaseFirestore get firestore => throw UnimplementedError();

  @override
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}

class MockFirebaseUser extends Mock implements firebase_auth.User {}

void main() {
  group('LoginScreen Widget Tests', () {
    late MockUserManager mockUserManager;

    setUp(() {
      mockUserManager = MockUserManager();
    });

    Future<void> pumpLoginScreen(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/signup': (context) => Scaffold(body: Text('Signup Screen')),
          },
          home: ChangeNotifierProvider<UserManager>.value(
            value: mockUserManager,
            child: LoginScreen(),
          ),
        ),
      );
    }

    testWidgets('renders LoginScreen with form fields and button', (WidgetTester tester) async {
      await pumpLoginScreen(tester);

      expect(find.text('Entrar'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Criar Conta'), findsOneWidget);
    });

    testWidgets('validates email and password fields', (WidgetTester tester) async {
      await pumpLoginScreen(tester);

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Digite seu e-mail'), findsOneWidget);
      expect(find.text('Senha deve ter pelo menos 6 caracteres'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField).first, 'invalid-email');
      await tester.pump();

      expect(find.text('E-mail inválido'), findsOneWidget);
    });

    testWidgets('calls signIn on valid form submission', (WidgetTester tester) async {
      await pumpLoginScreen(tester);

      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).last, 'password123');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(mockUserManager.signInCalled, true);
      expect(mockUserManager.emailPassed, 'test@example.com');
      expect(mockUserManager.passwordPassed, 'password123');
    });

    testWidgets('navigates to signup screen on Criar Conta button tap', (WidgetTester tester) async {
      await pumpLoginScreen(tester);

      await tester.tap(find.text('Criar Conta'));
      await tester.pumpAndSettle();

      expect(find.text('Signup Screen'), findsOneWidget);
    });
  });
}
