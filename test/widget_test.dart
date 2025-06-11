import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loja_virtual_pro/screens/base/base_screen.dart';
import 'package:loja_virtual_pro/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual_pro/common/custom_drawer/custom_drawer_header.dart';
import 'package:loja_virtual_pro/models/user_manager.dart';
import 'package:loja_virtual_pro/models/user.dart' as app_user;
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/mockito.dart';

class MockUserManager extends Mock implements UserManager {}

void main() {
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  group('BaseScreen Widget Tests', () {
    testWidgets('BaseScreen has PageView with 3 Scaffold children', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BaseScreen(),
        ),
      );

      expect(find.byType(PageView), findsOneWidget);
      expect(find.byType(Scaffold), findsNWidgets(3));
      expect(find.text('Home 2'), findsOneWidget);
      expect(find.text('Home 3'), findsOneWidget);
      expect(find.text('Home 4'), findsOneWidget);
      expect(find.byType(CustomDrawer), findsNWidgets(3));
    });
  });

  group('CustomDrawer Widget Tests', () {
    testWidgets('CustomDrawer has Drawer and ListView with expected children', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            drawer: CustomDrawer(),
          ),
        ),
      );

      expect(find.byType(Drawer), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(CustomDrawerHeader), findsOneWidget);
      expect(find.text('Inicio'), findsOneWidget);
      expect(find.text('Produtos'), findsOneWidget);
      expect(find.text('Meus Pedidos'), findsOneWidget);
      expect(find.text('Lojas'), findsOneWidget);
    });
  });

  group('CustomDrawerHeader Widget Tests', () {
    testWidgets('CustomDrawerHeader shows greeting and user name', (WidgetTester tester) async {
      final userManager = MockUserManager();
      when(userManager.user).thenReturn(null);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<UserManager>.value(
            value: userManager,
            child: const Scaffold(
              body: CustomDrawerHeader(),
            ),
          ),
        ),
      );

      // Since user is null, userName should be empty
      expect(find.textContaining('Bom dia'), findsOneWidget); // Greeting depends on current time
      expect(find.textContaining(','), findsOneWidget); // Greeting with comma and empty user name
    });

    testWidgets('CustomDrawerHeader shows user name when user is not null', (WidgetTester tester) async {
      final userManager = MockUserManager();
      when(userManager.user).thenReturn(app_user.User(
        id: '1',
        name: 'Test User',
        email: 'test@example.com',
        password: '',
        confirmPassword: '',
      ));

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<UserManager>.value(
            value: userManager,
            child: const Scaffold(
              body: CustomDrawerHeader(),
            ),
          ),
        ),
      );

      expect(find.textContaining('Test User'), findsOneWidget);
    });
  });
}
