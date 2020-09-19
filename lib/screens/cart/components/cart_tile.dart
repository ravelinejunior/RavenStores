import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/common/custom_widgets/custom_icon_button.dart';
import 'package:ravelinestores/models/cart_products.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;
  const CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    //color
    final Color color = Theme.of(context).primaryColor;
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              //imagem
              if (cartProduct.product.images != null)
                FadeInImage.assetNetwork(
                  placeholder: 'assets/cartshop.gif',
                  image: cartProduct.product.images.first.toString(),
                  fit: BoxFit.cover,
                  height: 80,
                  width: 80,
                ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //textos de detalhes
                    children: [
                      //nome widget
                      Text(
                        cartProduct.product.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      //tamanho widget
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Tipo: ${cartProduct.size}',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16.0,
                          ),
                        ),
                      ),

                      //preço widget, verificar se existe stock
                      Consumer<CartProduct>(
                        builder: (context, cartProduct, child) {
                          if (cartProduct.hasStock)
                            return Text(
                              'R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: color),
                            );
                          else
                            return Text(
                              cartProduct.itemSize.stock > 1
                                  ? 'Desculpe belo cliente, só temos ${cartProduct.itemSize.stock} itens no estoque!'
                                  : 'Desculpe belo cliente, só temos ${cartProduct.itemSize.stock} item no estoque!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 14.0,
                                  color: Colors.red[700]),
                            );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              //add quantidade produtos widget
              Consumer<CartProduct>(
                builder: (context, cartProduct, child) {
                  return Column(
                    children: [
                      CustomIconButton(
                        iconData: Icons.add,
                        color: color,
                        onTap: cartProduct.incrementQuantity,
                      ),

                      //quantidade data
                      Text(
                        '${cartProduct.quantity}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.grey),
                      ),

                      CustomIconButton(
                        iconData: Icons.remove,
                        color:
                            cartProduct.quantity > 1 ? Colors.blue : Colors.red,
                        onTap: cartProduct.removeQuantity,
                      ),

                      //remover produto
                      FlatButton.icon(
                        splashColor: Colors.red,
                        onPressed: () {
                          showDialog(
                              context: context,
                              child: AlertDialog(
                                title: Text("Excluir"),
                                content:
                                    Text("Deseja realmente excluir esse item?"),
                                actions: [
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Não",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      cartProduct.zeroProducts();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Sim",
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                                elevation: 20,
                                scrollable: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ));
                        },
                        icon: Icon(
                          Icons.remove_shopping_cart,
                          color: Colors.red,
                        ),
                        label: Text(
                          "Remover",
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
