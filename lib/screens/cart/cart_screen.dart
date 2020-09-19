import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/common/custom_widgets/empty_card.dart';
import 'package:ravelinestores/common/custom_widgets/login_card.dart';
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
          Consumer<CartManager>(
            builder: (context, cartManager, child) {
              if (cartManager.user != null && cartManager.items.isNotEmpty)
                return ListView(
                  children: [
                    Column(
                      //transformar os itens em uma lista e depois transformá-los em um cart tile customizávels
                      children: cartManager.items
                          .map((cartProduct) => CartTile(cartProduct))
                          .toList(),
                    ),
                    //resumo pedido widget
                    PriceCard(
                        buttonText: 'Continuar para Entrega',
                        onPressed: cartManager.isCartValid
                            ? () {
                                Navigator.of(context).pushNamed('/address');
                              }
                            : null,
                        icon: cartManager.isCartValid
                            ? Icon(Icons.add_shopping_cart)
                            : Icon(Icons.remove_shopping_cart),
                        color: cartManager.isCartValid
                            ? Color.fromARGB(255, 46, 125, 168)
                            : Colors.redAccent.withAlpha(100)),
                  ],
                );
              else if (cartManager.user != null && cartManager.items.isEmpty)
                return EmptyCard(
                  iconData: Icons.remove_shopping_cart,
                  title:
                      "Você ainda não adicionou nenhum produto no carrinho. Que tal fazer umas comprinhas ?!",
                );
              else
                return LoginCard();
            },
          )
        ],
      ),
    );
  }
}
