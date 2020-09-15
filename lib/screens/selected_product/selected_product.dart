import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/managers/product_manager.dart';

class SelectedProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vincular Produto'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Consumer<ProductManager>(
        builder: (_, productManager, child__) {
          return ListView.builder(
            itemCount: productManager.allProducts.length,
            itemBuilder: (context__, index) {
              //recuperar produtos pra montagem da tela
              final product = productManager.allProducts[index];
              return Card(
                elevation: 5,
                child: ListTile(
                  leading: Container(
                    child: FadeInImage.assetNetwork(
                      width: 100,
                      placeholder: 'assets/cartshop.gif',
                      image: product.images.first as String,
                      fit: BoxFit.fill,
                    ),
                  ),
                  title: Text(
                    '${product.name}',
                    overflow: TextOverflow.fade,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'R\$ ${product.basePrice.toStringAsFixed(2)}',
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(product);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
