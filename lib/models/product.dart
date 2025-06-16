import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  // Campos do produto
  late final String id;
  late final String name;
  late final String description;
  late final List<String> images;

  // Construtor que cria um produto a partir de um documento do Firestore
  Product.fromDocument(DocumentSnapshot document) :
    id = document.id,
    name = document['name'] as String,
    description = document['description'] as String,
    images = List<String>.from(document['images'] as List<dynamic>);
}
