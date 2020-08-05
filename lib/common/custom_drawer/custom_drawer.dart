import 'package:flutter/material.dart';
import 'package:ravelinestores/common/custom_drawer/drawer_tile.dart';

import 'custom_drawer_header.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          //cores degrade
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  //const Color.fromARGB(255, 203, 236, 241),
                  const Color.fromARGB(255, 150, 180, 255),
                  Colors.white
                  // const Color.fromARGB(255, 140, 150, 255),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              //criar um objeto que representa um item do drawer
              //widget Inicial
              CustomDrawerHeader(),
              Divider(),
              DrawerTile(Icons.home, "Home", 0),
              DrawerTile(Icons.category, "Categorias", 1),
              DrawerTile(Icons.format_list_numbered, "Produtos", 2),
              DrawerTile(Icons.format_list_bulleted, "Meus Pedidos", 3),
              DrawerTile(Icons.location_on, "Lojas", 4),
              //footer
            ],
          ),
        ],
      ),
    );
  }
}
