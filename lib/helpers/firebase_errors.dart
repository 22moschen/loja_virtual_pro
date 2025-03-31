String getErrorString(String code) {
  switch (code) {
    case 'weak-password':
      return 'Sua senha é muito fraca.';
    case 'invalid-email':
      return 'Seu e-mail é inválido.';
    case 'email-already-in-use':
      return 'E-mail já está sendo utilizado em outra conta.';
    case 'wrong-password':
      return 'Senha incorreta. Verifique e tente novamente.';
    case 'user-not-found':
      return 'Não há usuário cadastrado com este e-mail.';
    case 'user-disabled':
      return 'Esta conta foi desativada.';
    case 'too-many-requests':
      return 'Muitas tentativas de login. Aguarde um momento e tente novamente.';
    case 'operation-not-allowed':
      return 'Operação não permitida.';
    case 'invalid-credential':
      return 'Credenciais inválidas. Verifique seu e-mail e senha.';

    default:
      return 'Ocorreu um erro inesperado. Tente novamente.';
  }
}
