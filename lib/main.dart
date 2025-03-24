import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/screens/base/base_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Modificado para super.key
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moschen Tecnologia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BaseScreen(), // Adicione const se BaseScreen for imutável
    );
  }
}