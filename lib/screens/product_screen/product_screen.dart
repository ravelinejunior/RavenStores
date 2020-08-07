import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:ravelinestores/models/product.dart';

class ProductScreen extends StatelessWidget {
  //recuperar produto clicado
  final Product product;
  const ProductScreen(this.product);

  @override
  Widget build(BuildContext context) {
    //cor
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          //widget editar
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () {},
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
            aspectRatio: 1,
            child: Carousel(
              images: product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotBgColor: Colors.transparent,
              dotIncreasedColor: primaryColor,
              dotColor: Colors.blueAccent,
              dotSize: 6,
              boxFit: BoxFit.cover,
              autoplay: true,
              autoplayDuration: Duration(seconds: 5),
              borderRadius: true,
            ),
          ),
          //textos widget
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //nome produto widget
                Text(
                  product.name,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
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
                  "R\$29,99",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 20.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Text(
                    "Descrição",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                //preço widget
                Text(
                  product.description,
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
