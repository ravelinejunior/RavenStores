import 'package:flutter/material.dart';
import 'package:ravelinestores/models/product.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductListTile extends StatelessWidget {
  //construtor para recuperar produtos
  ProductListTile(this.product);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            //IMAGEM WIDGET
            /*   AspectRatio(
              aspectRatio: 1, // para deixar imagem quadrada
              child: Image.network(product.images.first),
            ), */

            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: product.images.first,
              fit: BoxFit.fill,
            ),
            const SizedBox(width: 16),
            //TEXTOS WIDGET
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //nome
                  Text(
                    product.name,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800),
                  ),

                  //PREÇO WIDGET
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w400),
                    ),
                  ),

                  Text(
                    '19,99',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
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
