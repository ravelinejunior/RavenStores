import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/models/product.dart';

import 'components/images_form.dart';
import 'components/sizes_form.dart';

class EditProductScreen extends StatelessWidget {
  /* 
    caso produto seja nulo (add produto), criar um novo objeto
    se nao, passar o objeto selecionado e cloná-lo
    verificar se está editando se objeto diferente de nulo
  */
  final Product product;
  final bool editing;

  EditProductScreen(Product p)
      : editing = p != null,
        product = p != null ? p.clone() : Product();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //cores
    final Color color = Theme.of(context).primaryColor;
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(editing ? 'Editar Produto' : 'Criar Produto'),
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
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20.0),
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        hintText: 'Digite o título',
                        labelText: 'Título',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.grey),
                      ),
                      validator: (name) {
                        if (name.length < 4)
                          return 'Título muito curto';
                        else
                          return null;
                      },
                      onSaved: (name) => product.name = name,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
                      child: Text(
                        "A partir de",
                        style:
                            TextStyle(fontSize: 14.0, color: Colors.grey[600]),
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
                      decoration: InputDecoration(
                        labelText: 'Descrição',
                        hintText: 'Digite sua descrição',
                      ),
                      initialValue: product.description,
                      maxLines: null,
                      style: TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 16.0),
                      //salvar field
                      onSaved: (desc) => product.description = desc,
                    ),

                    //tamanhos custom widgets
                    SizesForm(product: product),

                    //botao de salvar alterações
                    Consumer<Product>(
                      builder: (context, product, child) {
                        return Container(
                          margin: const EdgeInsets.only(top: 16),
                          height: 54,
                          child: RaisedButton.icon(
                            onPressed: !product.loading
                                ? () async {
                                    if (formKey.currentState.validate()) {
                                      //chama o save em todos os campos
                                      formKey.currentState.save();
                                      await product.save();

                                      //atualizar produtos
                                      /*  context
                                          .read<ProductManager>()
                                          .update(product); */

                                      Navigator.of(context).pop();
                                    }
                                  }
                                : null,
                            splashColor: Colors.blue,
                            elevation: 10,
                            color: color,
                            textColor: Colors.white,
                            icon: !product.loading
                                ? Icon(
                                    Icons.done,
                                    color: Colors.white,
                                    size: 28,
                                  )
                                : Icon(
                                    Icons.timer,
                                    color: Colors.white.withAlpha(200),
                                    size: 16,
                                  ),
                            disabledColor: color.withAlpha(100),
                            label: product.loading
                                ? const CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                : const Text(
                                    'Salvar',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0),
                                  ),
                          ),
                        );
                      },
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
