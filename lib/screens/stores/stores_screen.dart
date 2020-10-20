import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/common/custom_drawer/custom_drawer.dart';
import 'package:ravelinestores/managers/stores_manager.dart';

class StoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text("Lojas"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 46, 92, 138),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [
                  Color.fromARGB(255, 46, 92, 138),
                  Color.fromARGB(255, 95, 168, 211),
                  Color.fromARGB(255, 98, 182, 203),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Consumer<StoresManager>(
            builder: (contextOut, storesManager, childOut) {
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
