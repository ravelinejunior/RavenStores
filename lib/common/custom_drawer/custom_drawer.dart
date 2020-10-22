import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/common/custom_drawer/drawer_tile.dart';
import 'package:ravelinestores/managers/user_manager.dart';

import 'custom_drawer_header.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(60)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Drawer(
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
                  DrawerTile(Icons.format_list_numbered, "Produtos", 1),
                  DrawerTile(Icons.format_list_bulleted, "Meus Pedidos", 2),
                  DrawerTile(Icons.location_on, "Lojas", 3),
                  DrawerTile(Icons.category, "Categorias", 4),

                  //admin part
                  Consumer<UserManager>(
                    builder: (context, userManager, child) {
                      if (userManager.adminEnabled) {
                        return Column(
                          children: [
                            const Divider(),
                            DrawerTile(Icons.settings, "Usuários", 5),
                            DrawerTile(Icons.settings_applications,
                                "Pedidos Realizados", 6),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
