import 'package:flutter/material.dart';
import 'package:ravelinestores/models/product.dart';

class ProductListTile extends StatelessWidget {
  //construtor para recuperar produtos
  const ProductListTile(this.product);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blueGrey,
      onTap: () {
        Navigator.of(context).pushNamed('/product', arguments: product);
        //o arguments vai para o settings do MAIN
      },
      child: Card(
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
              FadeInImage.assetNetwork(
                placeholder: 'assets/girlshopping.gif',
                image: product.images.first.toString(),
                fit: BoxFit.fill,
                height: 120,
                width: 120,
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
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w800),
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
                      'R\$ ${product.basePrice.toStringAsFixed(2)}',
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
      ),
    );
  }
}
