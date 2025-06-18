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
    name = (document.data() as Map<String, dynamic>?)?.containsKey('name') == true
        ? document.get('name') as String
        : '',
    description = (document.data() as Map<String, dynamic>?)?.containsKey('description') == true
        ? document.get('description') as String
        : '',
    images = (document.data() as Map<String, dynamic>?)?.containsKey('images') == true
        ? List<String>.from(document.get('images') as List<dynamic>)
        : [];
}
