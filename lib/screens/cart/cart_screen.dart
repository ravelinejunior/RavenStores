import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/common/custom_widgets/price_cart.dart';
import 'package:ravelinestores/managers/cart_manager.dart';
import 'package:ravelinestores/screens/cart/components/cart_tile.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (context, cartManager, child) {
          return ListView(
            children: [
              Column(
                //transformar os itens em uma lista e depois transformá-los em um cart tile customizável
                children: cartManager.items
                    .map((cartProduct) => CartTile(cartProduct))
                    .toList(),
              ),
              //resumo pedido widget
              PriceCard(
                buttonText: 'Continuar para Entrega',
                onPressed: cartManager.isCartValid ? () {} : null,
                icon: cartManager.isCartValid
                    ? Icon(Icons.add_shopping_cart)
                    : Icon(Icons.remove_shopping_cart),
              ),
            ],
          );
        },
      ),
    );
  }
}
