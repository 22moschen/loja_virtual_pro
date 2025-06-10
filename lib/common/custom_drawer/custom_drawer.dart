import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/common/custom_drawer/custom_drawer_header.dart';
import 'package:loja_virtual_pro/common/custom_drawer/drawer_title.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key}); // Adicionado const e super.key
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const <Widget>[ // Adicionado const aqui
          CustomDrawerHeader(),
          DrawerTile(iconData: Icons.home,
           title: 'Inicio', page: 0,),

          DrawerTile(iconData: Icons.list,
           title: 'Produtos', page: 1,),
           
          DrawerTile(iconData: Icons.playlist_add_check,
           title: 'Meus Pedidos', page: 2,),
           
          DrawerTile(iconData: Icons.location_on,
           title: 'Lojas', page: 3,),
        ],
      ),
    );
  }
}