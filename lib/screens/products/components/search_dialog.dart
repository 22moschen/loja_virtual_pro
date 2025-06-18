import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  const SearchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 2,
          left: 4,
          right: 4,
          child: Card(
            child: TextFormField(
              textInputAction: TextInputAction.search, // lupa no teclado
              autofocus: true, // ao clicar já abre o teclado
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                prefixIcon: IconButton(
                  icon: Icon(Icons.arrow_back), // icon seta de voltar
                  color: Colors.grey[700],
                  onPressed: () {
                    Navigator.of(context).pop(); // ao clicar na seta fecha a tela com pop()
                  },
                ),
              ),
              onFieldSubmitted: (text) {
                //passa o texto digitado para products_screen
                Navigator.of(context).pop(text);
              },
            ),
          ),
        ),
      ],
    );
  }
}
