import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/managers/cart_manager.dart';

class PriceCard extends StatelessWidget {
  //construtor
  PriceCard({this.buttonText, this.onPressed, this.icon});

  final String buttonText;
  final VoidCallback onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    //utilizar um watch no build para alterar todo widget
    //toda vez que houver alteração no cartManager, ele rebuilda a tela
    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;
    final totalPriceTemp = productsPrice + 5.99;

    return Card(
      elevation: 10,
      shadowColor: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Resumo do meu Pedido',
              textAlign: TextAlign.start,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            //linha de subTotal
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal'),
                  Text(
                    'R\$ ${productsPrice.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            //linha de frete
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Entrega/Frete'),
                  Text(
                    'R\$ 5,99',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            //linha de total
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total'),
                  Text(
                    'R\$ ${totalPriceTemp.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: primaryColor),
                  ),
                ],
              ),
            ),

            //botao continuar compra
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              height: 50,
              child: RaisedButton.icon(
                splashColor: Colors.blue,
                elevation: 10,
                color: primaryColor,
                onPressed: onPressed,
                disabledElevation: 10,
                disabledColor: Colors.red.withAlpha(100),
                disabledTextColor: Colors.black.withAlpha(100),
                icon: icon,
                label: Text(buttonText),
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
