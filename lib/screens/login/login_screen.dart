//import 'package:firebase_auth/firebase_auth.dart';
import 'package:loja_virtual_pro/models/user.dart' as app_user;
import 'package:loja_virtual_pro/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/helpers/validators.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Entrar'),
        titleTextStyle: TextStyle( color:  Colors.white),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            child: const Text('Criar Conta', style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 26),
          child: Form(
            key: formkey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      controller: emailController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Digite seu e-mail';
                        }
                        if (!emailValid(email)) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'Senha'),
                      autocorrect: false,
                      obscureText: true,
                      validator: (pass) {
                        if (pass != null && (pass.isEmpty || pass.length < 6)) {
                          return 'Senha deve ter pelo menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Esqueci minha senha'),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed:
                            userManager.loading
                                ? null
                                : () {
                                  if (formkey.currentState?.validate() ??
                                      false) {
                                    userManager.signIn(
                                      user: app_user.User(
                                        email: emailController.text,
                                        password: passwordController.text, name: 'name', confirmPassword: 'confirmPassword',
                                        id: 'id'
                                      ),
                                      onFail: (e) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(content: Text(e.toString())),
                                        );
                                      },
                                      onSuccess: (user) {
                                        // TODO: FECHAR TELA DE LOGIN
                                        //Navigator.of(context).pop();
                                      },
                                    );
                                  }
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          disabledIconColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        child:
                            userManager.loading
                                ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                    Color.fromARGB(255, 4, 125, 144),
                                  ),
                                )
                                : const Text(
                                  'Entrar',
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
    );
  }
}
