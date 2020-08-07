import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:ravelinestores/models/product.dart';

class ProductScreen extends StatelessWidget {
  //recuperar produto clicado
  final Product product;
  const ProductScreen(this.product);

  @override
  Widget build(BuildContext context) {
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
              dotSize: 5,
              dotHorizontalPadding: 5,
              boxFit: BoxFit.cover,
              autoplay: true,
              autoplayDuration: Duration(seconds: 5),
              borderRadius: true,
            ),
          ),
        ],
      ),
    );
  }
}
