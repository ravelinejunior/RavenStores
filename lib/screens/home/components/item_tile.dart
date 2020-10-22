import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ravelinestores/managers/home_manager.dart';
import 'package:ravelinestores/managers/product_manager.dart';
import 'package:ravelinestores/models/product.dart';
import 'package:ravelinestores/models/section.dart';
import 'package:ravelinestores/models/section_item.dart';

import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(this.item);
  final SectionItem item;
  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    final Color colorP = Theme.of(context).primaryColor;
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(
        right: Radius.circular(30),
        left: Radius.circular(30),
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: GestureDetector(
          onTap: () {
            //verificar se produto está vinculado a imagem
            if (item.product != null) {
              //buscar produto correspondente ao id
              final product =
                  context.read<ProductManager>().findProductbyId(item.product);
              //verificar se produto foi encontrado
              if (product != null) {
                Navigator.of(context).pushNamed('/product', arguments: product);
              }
            }
          },

          //excluir ou vincular produto na tela de home
          onLongPress: homeManager.editing
              ? () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      //recuperar produto por id tocada
                      final product = context
                          .read<ProductManager>()
                          .findProductbyId(item.product);

                      return AlertDialog(
                        title: const Text(
                          'Editar produto',
                          textAlign: TextAlign.center,
                        ),
                        content: product != null
                            ? ListTile(
                                leading: item.image is String
                                    ? Card(
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                              'assets/shimmerloadingodd.gif',
                                          image: item.image as String,
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                    : Card(
                                        child: Image.file(
                                          item.image as File,
                                          fit: BoxFit.cover,
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
                                      color: colorP,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : null,
                        contentPadding: const EdgeInsets.all(16),
                        actions: [
                          FlatButton.icon(
                            onPressed: () {
                              context.read<Section>().removeItem(item);
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                            label: Text(
                              'Excluir',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),

                          //vincular ou desvincular produto
                          FlatButton.icon(
                            onPressed: () async {
                              //se produto vinculado, desvincular
                              if (product != null) {
                                item.product = null;
                              } else {
                                //vincular produto
                                final Product product =
                                    await Navigator.of(context)
                                            .pushNamed('/selectedProduct')
                                        as Product;

                                //colocar o produto no item
                                item.product = product?.id;
                              }
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              product != null
                                  ? Icons.leak_remove
                                  : Icons.add_to_home_screen,
                              color: colorP,
                            ),
                            label: Text(
                              product != null ? 'Desvincular' : 'Vincular',
                              style: TextStyle(color: colorP),
                            ),
                          )
                        ],
                      );
                    },
                  );
                }
              : null,

          child: item.image is String
              ? FadeInImage.assetNetwork(
                  placeholder: 'assets/girlshopping.gif',
                  placeholderCacheHeight: 300,
                  placeholderCacheWidth: 300,
                  image: item.image as String,
                  fit: BoxFit.cover,
                )
              : Image.file(
                  item.image as File,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
