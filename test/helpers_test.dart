import 'package:flutter_test/flutter_test.dart';
import 'package:loja_virtual_pro/helpers/firebase_errors.dart';
import 'package:loja_virtual_pro/helpers/validators.dart';

void main() {
  group('Firebase Errors Tests', () {
    test('getErrorString returns correct messages for known codes', () {
      expect(getErrorString('weak-password'), 'Sua senha é muito fraca.');
      expect(getErrorString('invalid-email'), 'Seu e-mail é inválido.');
      expect(getErrorString('email-already-in-use'), 'E-mail já está sendo utilizado em outra conta.');
      expect(getErrorString('wrong-password'), 'Senha incorreta. Verifique e tente novamente.');
      expect(getErrorString('user-not-found'), 'Não há usuário cadastrado com este e-mail.');
      expect(getErrorString('user-disabled'), 'Esta conta foi desativada.');
      expect(getErrorString('too-many-requests'), 'Muitas tentativas de login. Aguarde um momento e tente novamente.');
      expect(getErrorString('operation-not-allowed'), 'Operação não permitida.');
      expect(getErrorString('invalid-credential'), 'Credenciais inválidas. Verifique seu e-mail e senha.');
    });

    test('getErrorString returns default message for unknown code', () {
      expect(getErrorString('unknown-code'), 'Ocorreu um erro inesperado. Tente novamente.');
    });
  });

  group('Validators Tests', () {
    test('emailValid returns true for valid emails', () {
      expect(emailValid('test@example.com'), true);
      expect(emailValid('user.name+tag+sorting@example.com'), true);
      expect(emailValid('user_name@example.co.uk'), true);
    });

    test('emailValid returns false for invalid emails', () {
      expect(emailValid('plainaddress'), false);
      expect(emailValid('@@example.com'), false);
      expect(emailValid('email.example.com'), false);
      expect(emailValid('email@example@example.com'), false);
      expect(emailValid('email@example'), false);
    });
  });
}
