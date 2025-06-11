import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/common/custom_drawer/custom_drawer_header.dart';
import 'package:loja_virtual_pro/common/custom_drawer/drawer_title.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 183, 234, 241),
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            width: double.infinity,
            height: double.infinity,
          ),
          ListView(
            children: [
              const CustomDrawerHeader(),
              const 
              Divider(),
              const DrawerTile(
                iconData: Icons.home,
                title: 'Inicio',
                page: 0,
              ),
              const DrawerTile(
                iconData: Icons.list,
                title: 'Produtos',
                page: 1,
              ),
              const DrawerTile(
                iconData: Icons.playlist_add_check,
                title: 'Meus Pedidos',
                page: 2,
              ),
              const DrawerTile(
                iconData: Icons.location_on,
                title: 'Lojas',
                page: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
