import 'package:flutter/material.dart';
import 'package:ravelinestores/common/custom_drawer/custom_drawer.dart';

class BaseScreen extends StatelessWidget {
  //page view que irá controlar o page view
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
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
        Container(color: Colors.amber),
        Container(color: Colors.red),
        Container(color: Colors.blue),
      ],
    );
  }
}
