import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:loja_virtual_pro/models/product.dart';

class ProductManager extends ChangeNotifier {
  List<Product> allProducts = [];

  ProductManager() {
    // Carrega todos os produtos ao inicializar a classe
    _loadAllProducts();
  }

  // Getter para acessar a lista de produtos
  //List<Product> get allProducts => List.unmodifiable(_allProducts);

  // Instância do FirebaseFirestore para acessar o Firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  // Função assíncrona para carregar todos os produtos da coleção 'products'
  Future<void> _loadAllProducts() async {
    // Obtém os documentos da coleção 'products'
    final QuerySnapshot snapProducts =
        await firestore.collection('products').get();

    // Converte os documentos para objetos Product e armazena na lista
    allProducts =
        snapProducts.docs.map((d) => Product.fromDocument(d)).toList();

    // Notifica os listeners sobre a atualização dos produtos
    notifyListeners();
  }
}
