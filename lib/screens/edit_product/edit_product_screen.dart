import 'package:flutter/material.dart';
import 'package:ravelinestores/models/product.dart';

import 'components/images_form.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;
  const EditProductScreen(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          //campo images
          ImagesForm(product),
        ],
      ),
    );
  }
}
