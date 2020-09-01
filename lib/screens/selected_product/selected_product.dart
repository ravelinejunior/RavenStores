import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/managers/product_manager.dart';
import 'package:transparent_image/transparent_image.dart';

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
                  leading: FadeInImage.assetNetwork(
                    alignment: Alignment.center,
                    placeholder: 'assets/discuss.gif',
                    image: product.images.first as String,
                    fit: BoxFit.fill,
                    width: 125,
                    height: 150,
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
