import 'package:flutter/material.dart';
import 'package:ravelinestores/models/order.dart';
import 'export_address_dialog.dart';
import 'order_product_tile.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  final bool showControls;
  const OrderTile(this.order, {this.showControls = false});
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
                    color:
                        order.status == Status.canceled ? Colors.red : pColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "R\$ ${order.price.toStringAsFixed(2).replaceAll(".", ",")}",
                  style: TextStyle(
                    color:
                        order.status == Status.canceled ? Colors.red : pColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            //STATUS TEXT
            Text(
              order.statusText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: order.status == Status.canceled ? Colors.red : pColor,
              ),
            ),
          ],
        ),
        children: [
          Column(
            children: order.items.map(
              (e) {
                return OrderProductTile(e);
              },
            ).toList(),
          ),
          Divider(),
          if (showControls && order.status != Status.canceled)
            //lista de botões
            SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FlatButton.icon(
                    splashColor: Colors.red.withAlpha(100),
                    onPressed: () {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            title:
                                Text('Cancelar pedido ${order.formattedId}!'),
                            elevation: 5,
                            scrollable: true,
                            content: Text(
                                "Deseja realmente cancelar o pedido ${order.formattedId}?"),
                            actions: [
                              FlatButton(
                                //REMOVER
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Não',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              FlatButton(
                                //REMOVER
                                onPressed: () {
                                  order.cancel();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Sim',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ));
                    },
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                    label: Text(
                      'Cancelar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ),

                  //recuar
                  FlatButton.icon(
                    splashColor: Colors.red.withAlpha(100),
                    onPressed: order.back,
                    disabledTextColor: Colors.black.withAlpha(100),
                    textColor: Colors.red,
                    icon: Icon(
                      Icons.arrow_back,
                      color: order.status.index <= Status.preparing.index
                          ? Colors.red.withAlpha(100)
                          : Colors.red,
                    ),
                    label: Text(
                      'Recuar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),

                  //avançar
                  FlatButton.icon(
                    splashColor: Theme.of(context).primaryColor.withAlpha(100),
                    disabledTextColor: Colors.black.withAlpha(100),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: order.advance,
                    icon: Icon(
                      Icons.arrow_forward,
                      color: order.status.index >= Status.delivered.index
                          ? Theme.of(context).primaryColor.withAlpha(100)
                          : Theme.of(context).primaryColor,
                    ),
                    label: Text(
                      'Avançar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  FlatButton.icon(
                    splashColor: Colors.blue.withAlpha(100),
                    disabledColor: Colors.blueAccent.withAlpha(100),
                    disabledTextColor: Colors.white.withAlpha(100),
                    textColor: Colors.blue[800],
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return ExportAddressDialog(order.address);
                        },
                      );
                    },
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.blue[800],
                    ),
                    label: Text(
                      'Endereço',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
