import 'package:flutter/material.dart';
import 'package:ravelinestores/common/custom_drawer/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      //efeitos no body
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: const [
                Color.fromARGB(255, 46, 92, 138),
                Color.fromARGB(255, 95, 168, 211),
                Color.fromARGB(255, 98, 182, 203),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                actions: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart, color: Colors.white),
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                    splashColor: Colors.orange,
                  )
                ],
                elevation: 0,
                backgroundColor: Colors.transparent,
                snap: true,
                floating: true,
                flexibleSpace: const FlexibleSpaceBar(
                  title: const Text('Comercial Desafio'),
                  centerTitle: true,
                ),
              ),
              //transforma widgets em widgets slivers
              SliverToBoxAdapter(
                child: Container(
                  height: 1000,
                  width: 500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
