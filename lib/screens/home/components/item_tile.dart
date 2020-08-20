import 'package:flutter/material.dart';
import 'package:ravelinestores/managers/product_manager.dart';
import 'package:ravelinestores/models/section_item.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(this.item);
  final SectionItem item;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.deepOrangeAccent,
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
      child: Card(
        elevation: 15,
        shadowColor: Colors.grey,
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: item.image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
