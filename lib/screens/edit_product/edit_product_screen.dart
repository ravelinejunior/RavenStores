import 'package:flutter/material.dart';
import 'package:ravelinestores/models/product.dart';

import 'components/images_form.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;
  EditProductScreen(this.product);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //cores
    final Color color = Theme.of(context).primaryColor;
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
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            //campo images
            ImagesForm(product),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //campo de titulo do produto
                  TextFormField(
                    initialValue: product.name,
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
                    enableSuggestions: true,
                    decoration: InputDecoration(
                      hintText: 'Digite o título',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.grey),
                    ),
                    validator: (name) {
                      if (name.length < 4)
                        return 'Título muito curto';
                      else
                        return null;
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
                    child: Text(
                      "A partir de",
                      style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                    ),
                  ),

                  //preço widget
                  Text(
                    "R\$...",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
                    child: Text(
                      "Descrição",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  //descrição widget
                  TextFormField(
                    validator: (text) {
                      if (text.length < 10) return 'Mínimo de 10 caracteres';
                      return null;
                    },
                    initialValue: product.description,
                    maxLines: null,
                    style:
                        TextStyle(fontStyle: FontStyle.italic, fontSize: 16.0),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    height: 54,
                    child: RaisedButton.icon(
                      onPressed: () {
                        if (formKey.currentState.validate()) {}
                      },
                      elevation: 10,
                      color: color,
                      textColor: Colors.white,
                      icon: Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 28,
                      ),
                      label: const Text(
                        'Salvar',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18.0),
                      ),
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
