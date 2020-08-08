import 'package:flutter/material.dart';
import 'package:ravelinestores/models/item_size.dart';
import 'package:provider/provider.dart';
import 'package:ravelinestores/models/product.dart';

class SizeWidget extends StatelessWidget {
  //construtor
  final ItemSize size;
  const SizeWidget({this.size});

  @override
  Widget build(BuildContext context) {
    //recuperar acesso ao produto selecionado
    final product = context.watch<Product>();
    final selected = size == product.selectedSize;

    Color color;

    if (!size.hasStock)
      color = Colors.red.withAlpha(60);
    else if (selected) {
      color = Theme.of(context).primaryColor;
    } else
      color = Colors.grey;

    return InkWell(
      onTap: () {
        if (size.hasStock) {
          product.selectedSize = size;
        }
      },
      splashColor: color,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              //verificar se existe no estoque, e alterar a cor de não existir
              color: color),
        ),
        child: Row(
          //para minimizar o tamanho da row
          mainAxisSize: MainAxisSize.min,
          children: [
            //nome do tamanho widget
            Container(
              alignment: Alignment.center,
              height: 45,
              color: color,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                size.name,
                style: TextStyle(color: Colors.white),
              ),
            ),

            //container que vai obter o preço de cada tamanho widget
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "R\$ ${size.price.toStringAsFixed(2)}",
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
