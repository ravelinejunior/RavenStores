import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/managers/cart_manager.dart';
import 'package:ravelinestores/managers/user_manager.dart';

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
    final userManager = context.watch<UserManager>();

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
                    userManager.isLoggedIn
                        ? 'R\$ ${productsPrice.toStringAsFixed(2).replaceAll('.', ',')}'
                        : "R\$ 0,00",
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
                    userManager.isLoggedIn ? 'R\$ 5,99' : 'R\$ 0,00',
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
                    userManager.isLoggedIn
                        ? 'R\$ ${totalPriceTemp.toStringAsFixed(2).replaceAll('.', ',')}'
                        : 'R\$ 0,00',
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
                color: userManager.isLoggedIn
                    ? primaryColor
                    : Color.fromARGB(255, 46, 125, 168),
                onPressed: userManager.isLoggedIn
                    ? onPressed
                    : () {
                        Navigator.of(context).pushNamed('/login');
                      },
                disabledElevation: 10,
                disabledColor: Colors.red.withAlpha(100),
                disabledTextColor: Colors.black.withAlpha(100),
                icon:
                    userManager.isLoggedIn ? icon : Icon(Icons.alternate_email),
                label: userManager.isLoggedIn
                    ? Text(buttonText)
                    : Text('Faça o login para comprar :))'),
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
