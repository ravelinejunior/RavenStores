import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/common/custom_widgets/price_cart.dart';
import 'package:ravelinestores/managers/cart_manager.dart';

import 'components/address_card.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrega'),
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
          ListView(
            children: [
              AddressCard(),
              Consumer<CartManager>(
                builder: (contextOut, cartManager, childOut) {
                  return PriceCard(
                    buttonText: "Continuar com Pagamento",
                    onPressed: cartManager.isAddressValid
                        ? () {
                            Navigator.of(context).pushNamed('/payment');
                          }
                        : null,
                    icon: Icon(Icons.navigate_next),
                    color: Color.fromARGB(255, 46, 125, 168),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
