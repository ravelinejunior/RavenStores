import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/managers/cart_manager.dart';

import 'package:ravelinestores/managers/user_manager.dart';
import 'package:ravelinestores/models/product.dart';
import 'package:ravelinestores/screens/product_screen/components/size_widget.dart';

class ProductScreen extends StatelessWidget {
  //recuperar produto clicado
  final Product product;
  const ProductScreen(this.product);

  @override
  Widget build(BuildContext context) {
    //cor
    final Color primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            //widget editar
            Consumer<UserManager>(
              builder: (context, userManager, child) {
                //ENVIA PARA EDIÇÃO DE PRODUTO
                if (userManager.adminEnabled && !product.deleted)
                  return IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/editProduct',
                          arguments: product);
                    },
                    splashColor: Colors.orange,
                  );
                else
                  return IconButton(
                    icon: Icon(Icons.add_shopping_cart, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/cart');
                    },
                    splashColor: Colors.orange,
                  );
              },
            ),
          ],
          title: Text(product.name),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            //imagens carroussel
            AspectRatio(
              aspectRatio: 0.8,
              child: Carousel(
                images: product.images.map((url) {
                  return NetworkImage(url.toString());
                }).toList(),
                dotBgColor: Colors.transparent,
                dotIncreasedColor: primaryColor,
                dotColor: Colors.blueAccent,
                dotSize: 6,
                autoplay: false,
                boxFit: BoxFit.fill,
                borderRadius: true,
              ),
            ),
            //textos widget
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //nome produto widget
                  Text(
                    product.name,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Text(
                      "A partir de",
                      style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                    ),
                  ),

                  //preço widget
                  Text(
                    "R\$ ${product.basePrice.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Text(
                      "Descrição",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  //descrição widget
                  Text(
                    product.description,
                    style:
                        TextStyle(fontStyle: FontStyle.italic, fontSize: 16.0),
                  ),

                  //tamanhos widget

                  if (product.deleted)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                      child: Text(
                        "Produto indisponível no banco de dados.",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    )
                  else ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                      child: Text(
                        "Tipos",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    //usar para envolver os widgets
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: product.sizesList.map((s) {
                        return SizeWidget(size: s);
                      }).toList(),
                    ),
                  ],

                  const SizedBox(height: 16),
                  //botao add ao carrinho Widget
                  //utilizar consumer, pois botao dependerá do produto selecionado e do usuario logado
                  //verificar se existe stock geral, se nao, nem preciso criar o botao
                  if (product.hasStock)
                    Consumer2<UserManager, Product>(
                      builder: (context, userManager, product, _) {
                        return SizedBox(
                          height: 50.0,
                          child: RaisedButton.icon(
                            splashColor: Colors.blue,
                            icon: Icon(
                              product.selectedSize != null
                                  ? Icons.shopping_cart
                                  : Icons.remove_shopping_cart,
                              color: product.selectedSize != null
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            color: primaryColor,
                            textColor: Colors.white,
                            onPressed: product.selectedSize != null
                                ? () {
                                    //verificar se usuario está logado
                                    if (userManager.isLoggedIn) {
                                      context
                                          .read<CartManager>()
                                          .addToCart(product);
                                      //ir para tela de carrinho
                                      Navigator.of(context).pushNamed('/cart');
                                    } else {
                                      Navigator.of(context).pushNamed('/login');
                                    }
                                  }
                                : null,
                            label: Text(
                              //verificar se usuario logado
                              userManager.isLoggedIn
                                  ? 'Adicionar ao carrinho'
                                  : 'Entrar para Comprar',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                            ),
                          ),
                        );
                      },
                    ),

                  if (!product.hasStock)
                    SizedBox(
                      height: 50.0,
                      child: RaisedButton.icon(
                        icon: Icon(
                          product.selectedSize != null
                              ? Icons.shopping_cart
                              : Icons.remove_shopping_cart,
                          color: Colors.white,
                        ),
                        color: primaryColor,
                        textColor: Colors.white,
                        onPressed: product.selectedSize != null ? () {} : null,
                        label: Expanded(
                          child: Text(
                            //verificar se usuario logado
                            'Produtos temporariamente indisponíveis no estoque !',
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
