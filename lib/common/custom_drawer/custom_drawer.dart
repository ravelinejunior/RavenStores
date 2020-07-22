import 'package:flutter/material.dart';
import 'package:ravelinestores/common/custom_drawer/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          //criar um objeto que representa um item do drawer
          DrawerTile(Icons.home, "Home", 0),
          DrawerTile(Icons.category, "Categorias", 1),
          DrawerTile(Icons.format_list_numbered, "Produtos", 2),
          DrawerTile(Icons.format_list_bulleted, "Meus Pedidos", 3),
          DrawerTile(Icons.location_on, "Lojas", 4),
        ],
      ),
    );
  }
}
