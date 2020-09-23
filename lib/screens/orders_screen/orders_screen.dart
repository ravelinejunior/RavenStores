import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/common/custom_drawer/custom_drawer.dart';
import 'package:ravelinestores/common/custom_widgets/empty_card.dart';
import 'package:ravelinestores/common/custom_widgets/login_card.dart';
import 'package:ravelinestores/managers/orders_manager.dart';

import 'components/order_tile.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Pedidos"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 46, 92, 138),
      ),
      drawer: CustomDrawer(),
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
          Consumer<OrdersManager>(
            builder: (contextOut, ordersManager, childOut) {
              if (ordersManager.user == null) return LoginCard();
              if (ordersManager.orders.isEmpty)
                return EmptyCard(
                  title:
                      "Ainda não adquiriu nada? Corra e aproveite nossas ofertas.",
                  iconData: Icons.border_clear,
                );
              return ListView.builder(
                itemCount: ordersManager.orders.length,
                itemBuilder: (_, index) {
                  return OrderTile(
                      ordersManager.orders.reversed.toList()[index]);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
