import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/common/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual_pro/models/page_manager.dart';
//import 'package:loja_virtual_pro/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({super.key}); // Corrigido para usar super.key

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[

        

        Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            title: const Text('Home 2'),
          ),
        ),

          Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            title: const Text('Home 3'),
          ),
        ),

          Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            title: const Text('Home 4'),
          ),
        ),


      ],
      ),
    );
  }
}
