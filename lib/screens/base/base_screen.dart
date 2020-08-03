import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/common/custom_drawer/custom_drawer.dart';
import 'package:ravelinestores/models/page_manager.dart';

class BaseScreen extends StatelessWidget {
  //page view que irá controlar o page view
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider(
      //será utilizado para verificar o estado da pagina atual
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        //colocar as telas dentro do children
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: const Text("Home"),
              centerTitle: true,
            ), //DRAWER WIDGET
            drawer: CustomDrawer(),
          ),
          Scaffold(
            appBar: AppBar(
              title: const Text("Home2"),
              centerTitle: true,
              backgroundColor: Colors.deepPurple,
            ), //DRAWER WIDGET
            drawer: CustomDrawer(),
          ),
          Scaffold(
            appBar: AppBar(
              title: const Text("Home3"),
              backgroundColor: Colors.grey,
              centerTitle: true,
            ), //DRAWER WIDGET
            drawer: CustomDrawer(),
          ),
          Scaffold(
            appBar: AppBar(
              title: const Text("Home4"),
              backgroundColor: Colors.red,
              centerTitle: true,
            ), //DRAWER WIDGET
            drawer: CustomDrawer(),
          ),
        ],
      ),
    );
  }
}
