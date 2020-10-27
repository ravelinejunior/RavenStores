import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/managers/cart_manager.dart';
import 'package:ravelinestores/managers/user_manager.dart';

class PriceCard extends StatelessWidget {
  //construtor
  PriceCard({this.buttonText, this.onPressed, this.icon, this.color});

  final String buttonText;
  final VoidCallback onPressed;
  final Icon icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    //utilizar um watch no build para alterar todo widget
    //toda vez que houver alteração no cartManager, ele rebuilda a tela
    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;
    final totalPriceTemp = cartManager.totalPrice;
    final userManager = context.watch<UserManager>();
    final deliveryPrice = cartManager.deliveryPrice;

    return Card(
      elevation: 10,
      shadowColor: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Resumo do meu pedido'.toUpperCase(),
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            Divider(),
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
                    userManager.isLoggedIn && deliveryPrice != null
                        ? 'R\$ ${deliveryPrice.toStringAsFixed(2).replaceAll('.', ',')}'
                        : 'R\$ 0,00',
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
                        ? 'R\$ ${(totalPriceTemp).toStringAsFixed(2).replaceAll('.', ',')}'
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
                shape: const StadiumBorder(),
                splashColor: Colors.blue,
                elevation: 10,
                color: userManager.isLoggedIn
                    ? color
                    : Color.fromARGB(255, 46, 125, 168),
                onPressed: userManager.isLoggedIn
                    ? onPressed
                    : () {
                        Navigator.of(context).pushNamed('/login');
                      },
                disabledElevation: 10,
                disabledColor: color.withAlpha(100),
                disabledTextColor: Colors.black.withAlpha(100),
                icon:
                    userManager.isLoggedIn ? icon : Icon(Icons.alternate_email),
                label: userManager.isLoggedIn
                    ? Text(buttonText)
                    : Text('Faça o login para comprar!'),
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
