import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:loja_virtual_pro/models/product.dart';

class ProductListTile extends StatelessWidget {
  final Product product;

  const ProductListTile(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    final imageString = product.images.isNotEmpty ? product.images.first : '';

    // Verifica se a imagem está codificada em base64 (data URI)
    if (imageString.startsWith('data:image/')) {
      // Decodifica a string base64 para bytes e exibe a imagem em memória
      final base64Str = imageString.split(',').last;
      final bytes = base64Decode(base64Str);
      imageWidget = Image.memory(bytes, fit: BoxFit.cover);
    } else if (imageString.isNotEmpty) {
      // Caso contrário, assume que é uma URL e carrega a imagem da rede
      imageWidget = Image.network(imageString, fit: BoxFit.cover);
    } else {
      // Se não houver imagem, exibe um container cinza como placeholder
      imageWidget = Container(color: Colors.grey, width: 100, height: 100);
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4)
      ),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: imageWidget,
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Apartir de',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 12,
                    ),
                    ),
                  ),
                  Text(
                    'R\$ 159.000,00',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).primaryColor
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
