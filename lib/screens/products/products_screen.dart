import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/common/custom_drawer/custom_drawer.dart';
import 'package:ravelinestores/managers/product_manager.dart';
import 'package:ravelinestores/screens/products/components/product_list_tile.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Produtos',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[],
      ),
      drawer: CustomDrawer(),
      //para carregar itens de maneira progressiva
      body: Consumer<ProductManager>(
        builder: (context, productManager, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(4.0),
            //especificar quantos itens o builder possui
            itemCount: productManager.allProducts.length,
            itemBuilder: (context, index) {
              return ProductListTile(productManager.allProducts[index]);
            },
          );
        },
      ),
    );
  }
}
