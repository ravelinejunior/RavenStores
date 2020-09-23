import 'package:flutter/material.dart';
import 'package:ravelinestores/models/order.dart';
import 'order_product_tile.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  const OrderTile(this.order);
  @override
  Widget build(BuildContext context) {
    final pColor = Theme.of(context).primaryColor;
    return Card(
      shadowColor: Colors.white,
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.formattedId,
                  style: TextStyle(
                    color: pColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "R\$ ${order.price.toStringAsFixed(2).replaceAll(".", ",")}",
                  style: TextStyle(
                    color: pColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            //STATUS TEXT
            Text(
              "Pendente",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: pColor,
              ),
            ),
          ],
        ),
        children: [
          Column(
            children: order.items.map((e) {
              return OrderProductTile(e);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
