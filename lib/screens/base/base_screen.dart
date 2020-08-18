import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/common/custom_drawer/custom_drawer.dart';
import 'package:ravelinestores/managers/page_manager.dart';
import 'package:ravelinestores/managers/user_manager.dart';
import 'package:ravelinestores/screens/home/home_screen.dart';
import 'package:ravelinestores/screens/products/products_screen.dart';

class BaseScreen extends StatelessWidget {
  //page view que irá controlar o page view
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider(
      //será utilizado para verificar o estado da pagina atual
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (context, userManager, child) {
          return PageView(
            controller: pageController,
            //colocar as telas dentro do children
            children: <Widget>[
              //home
              HomeScreen(),
              //Produtos Screen
              ProductsScreen(),

              Scaffold(
                appBar: AppBar(
                  title: const Text("Meus pedidos"),
                  backgroundColor: Colors.blue,
                  centerTitle: true,
                  shadowColor: Colors.orange,
                ), //DRAWER WIDGET
                drawer: CustomDrawer(),
              ),
              Scaffold(
                appBar: AppBar(
                  title: const Text("Lojas"),
                  elevation: 5,
                  shadowColor: Colors.orange,
                  backgroundColor: Colors.blueAccent,
                  centerTitle: true,
                ), //DRAWER WIDGET
                drawer: CustomDrawer(),
              ),

              Scaffold(
                appBar: AppBar(
                  title: const Text("Categorias"),
                  elevation: 5,
                  shadowColor: Colors.orange,
                  backgroundColor: Colors.blueAccent,
                  centerTitle: true,
                ), //DRAWER WIDGET
                drawer: CustomDrawer(),
              ),

              //admin part
              if (userManager.adminEnabled) ...[
                Scaffold(
                  appBar: AppBar(
                    title: const Text("Usuarios"),
                    elevation: 5,
                    backgroundColor: Colors.indigo,
                    centerTitle: true,
                  ), //DRAWER WIDGET
                  drawer: CustomDrawer(),
                ),
                Scaffold(
                  appBar: AppBar(
                    title: const Text("Pedidos realizados"),
                    elevation: 5,
                    backgroundColor: Colors.indigoAccent,
                    centerTitle: true,
                  ), //DRAWER WIDGET
                  drawer: CustomDrawer(),
                ),
              ]
            ],
          );
        },
      ),
    );
  }
}
