import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/helpers/validators.dart';
import 'package:loja_virtual_pro/models/user.dart';
import 'package:loja_virtual_pro/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:loja_virtual_pro/common/wave_background.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = User(
    name: 'name',
    email: 'email',
    password: 'pass',
    confirmPassword: 'confirmPassword',
    id: 'id',
  );

  SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        titleTextStyle: const TextStyle(color: Colors.white),
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: WaveBackground(
        child: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 8, // Elevação para profundidade visual
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16), // Bordas arredondadas para visual moderno
            ),
            child: Form(
              key: formkey,
              child: Consumer<UserManager>(
                builder: (_, userManager, __) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: <Widget>[
                      // Campo nome completo com validação e feedback visual
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Nome Completo',
                          enabled: !userManager.loading,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                          ),
                        ),
                        validator: (name) {
                          if (name!.isEmpty) {
                            return 'Campo obrigatório';
                          } else if (name.trim().split(' ').length <= 1) {
                            return 'Preencha seu Nome Completo';
                          }
                          return null;
                        },
                        onSaved: (name) => user.name = name!,
                      ),
                      const SizedBox(height: 16),
                      // Campo email com validação e feedback visual
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'E-mail',
                          enabled: !userManager.loading,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (email) {
                          if (email!.isEmpty) {
                            return 'Campo obrigatório';
                          } else if (!emailValid(email)) {
                            return 'E-mail inválido';
                          }
                          return null;
                        },
                        onSaved: (email) => user.email = email!,
                      ),
                      const SizedBox(height: 16),
                      // Campo senha com validação e feedback visual
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Senha',
                          enabled: !userManager.loading,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                          ),
                        ),
                        obscureText: true,
                        validator: (pass) {
                          if (pass!.isEmpty) {
                            return 'O campo Senha não pode ser vazio! Insira sua senha.';
                          } else if (pass.length < 6) {
                            return 'A Senha deve conter no mínimo 6 caracteres!';
                          }
                          return null;
                        },
                        onSaved: (pass) => user.password = pass!,
                      ),
                      const SizedBox(height: 16),
                      // Campo confirmação de senha com validação e feedback visual
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Repita a Senha',
                          enabled: !userManager.loading,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                          ),
                        ),
                        autocorrect: false,
                        obscureText: true,
                        validator: (pass) {
                          if (pass!.isEmpty) {
                            return 'O campo senha não pode ser vazio! Insira sua senha.';
                          } else if (pass.length < 6) {
                            return 'A senha deve conter no mínimo 6 caracteres';
                          }
                          return null;
                        },
                        onSaved: (pass) => user.confirmPassword = pass!,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 44,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            disabledIconColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 6, // Elevação para efeito de botão elevado
                          ),
                          onPressed: userManager.loading
                              ? null
                              : () {
                                  if (formkey.currentState!.validate()) {
                                    formkey.currentState?.save();
                                    if (user.password != user.confirmPassword) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Text('Senhas não coincidem!'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return;
                                    }
                                    userManager.signUp(
                                      user: user,
                                      onSuccess: () {
                                        debugPrint('Sucesso');
                                        Navigator.of(context).pop();
                                      },
                                      onFail: (e) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: const Text('Falha ao cadastrar!'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                          child: userManager.loading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                )
                              : const Text(
                                  'Criar conta',
                                  style: TextStyle(fontSize: 18),
                                ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
