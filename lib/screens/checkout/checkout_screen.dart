import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/common/custom_widgets/price_cart.dart';
import 'package:ravelinestores/managers/cart_manager.dart';
import 'package:ravelinestores/managers/checkout_manager.dart';

class CheckoutScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final colorButton = const Color.fromARGB(255, 68, 120, 160);
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (contextOut) => CheckoutManager(),
      /* 
        sempre que houver alteração no cart, passar as informações de alteração para o checkout manager
       */
      update: (_, cartManager, checkoutManager) =>
          checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text("Pagamento"),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 46, 92, 138),
        ),
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: const [
                Color.fromARGB(255, 46, 92, 138),
                Color.fromARGB(255, 95, 168, 211),
                Color.fromARGB(255, 98, 182, 203),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          Consumer<CheckoutManager>(
            builder: (contextOut, checkoutManager, child) {
              if (!checkoutManager.loading)
                return ListView(
                  children: [
                    PriceCard(
                      buttonText: "Finalizar Pedido",
                      color: colorButton,
                      icon: Icon(Icons.payment),
                      onPressed: () {
                        checkoutManager.checkout(onStockFail: (e) {
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              elevation: 10,
                              content: Card(
                                elevation: 0,
                                color: Colors.red,
                                margin: const EdgeInsets.all(8),
                                child: Text(
                                  "PRODUTO ESGOTADO! REDIRECIONANDO USUARIO,AGUARDE ........",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 3),
                              behavior: SnackBarBehavior.floating,
                              shape: StadiumBorder(),
                            ),
                          );

                          Future.delayed(Duration(seconds: 3)).then(
                            (value) => Navigator.of(context).popUntil(
                                (route) => route.settings.name == '/cart'),
                          );
                        }, onSucess: () {
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              elevation: 10,
                              content: Card(
                                elevation: 0,
                                color: Colors.transparent,
                                margin: const EdgeInsets.all(8),
                                child: Text(
                                  "PEDIDO REALIZADO COM SUCESSO!!!",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 3),
                              behavior: SnackBarBehavior.floating,
                              shape: StadiumBorder(),
                            ),
                          );

                          Future.delayed(Duration(seconds: 2)).then(
                            (value) => Navigator.of(context).popUntil(
                                (route) => route.settings.name == '/base'),
                          );
                        });
                      },
                    ),
                  ],
                );
              else
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        strokeWidth: 5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      const SizedBox(height: 18.0),
                      Text(
                        'Estamos processando seu pedido...',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      )
                    ],
                  ),
                );
            },
          ),
        ]),
      ),
    );
  }
}
