import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/common/custom_drawer/custom_drawer.dart';
import 'package:ravelinestores/managers/product_manager.dart';
import 'package:ravelinestores/managers/user_manager.dart';
import 'package:ravelinestores/screens/products/components/product_list_tile.dart';
import 'package:ravelinestores/screens/products/components/search_dialog.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 46, 92, 138),
        //colocar consumer para verificar se usuario ja está pesquisando algo
        title: Consumer<ProductManager>(
          builder: (contextTitle, productManager, child) {
            if (productManager.search.isEmpty) {
              return const Text('Produtos');
            } else {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return GestureDetector(
                    onTap: () async {
                      final search = await showDialog<String>(
                        context: context,
                        builder: (_) => SearchDialog(productManager.search),
                      );

                      //verificar se pesquisa foi nula e enviar para product manager
                      if (search != null) {
                        productManager.search = search;
                      }
                    },
                    //para deixar o toque do texto com maxima largura
                    child: Container(
                      width: constraints.biggest.width,
                      child: Text(
                        productManager.search,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          //icone de pesquisa
          Consumer<ProductManager>(
            builder: (contextCons, productManager, childCons) {
              if (productManager.search.isEmpty) {
                return IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () async {
                    final search = await showDialog<String>(
                      context: context,
                      builder: (sContext) =>
                          SearchDialog(productManager.search),
                    );

                    //verificar se pesquisa foi nula e enviar para product manager
                    if (search != null) {
                      productManager.search = search;
                    }
                  },
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () async {
                    productManager.search = '';
                  },
                );
              }
            },
          ),

          //widget editar
          Consumer<UserManager>(
            builder: (context, userManager, child) {
              //ENVIA PARA EDIÇÃO DE PRODUTO
              if (userManager.adminEnabled)
                return IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      '/editProduct',
                    );
                  },
                  splashColor: Colors.orange,
                );
              else
                return Container();
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      //para carregar itens de maneira progressiva
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
          Consumer<ProductManager>(
            builder: (context, productManager, child) {
              //para otimizar pesquisa
              final filteredProducts = productManager.filteredProducts;
              return ListView.builder(
                padding: const EdgeInsets.all(4.0),
                //especificar quantos itens o builder possui
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ProductListTile(filteredProducts[index]);
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/cart');
        },
        hoverColor: Colors.orangeAccent,
        splashColor: Colors.orange,
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        elevation: 10,
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
