import 'package:flutter/material.dart';
import 'package:ravelinestores/models/order.dart';
import 'package:ravelinestores/screens/orders_screen/components/order_product_tile.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen(this.order);
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedido Confirmado'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 46, 92, 138),
      ),
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
          Center(
            child: Card(
              borderOnForeground: true,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
              margin: const EdgeInsets.all(16),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.formattedId,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'R\$ ${order.price.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: order.items.map((e) {
                      return OrderProductTile(e);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
