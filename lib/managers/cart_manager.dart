import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ravelinestores/managers/user_manager.dart';
import 'package:ravelinestores/models/cart_products.dart';
import 'package:ravelinestores/models/product.dart';
import 'package:ravelinestores/models/user.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = [];
  User user;

  //ADD PRODUCTS
  void addToCart(Product product) {
    try {
      //empilhar produtos iguais
      final stack = items.firstWhere((p) => p.stackable(product));
      stack.incrementQuantity();
    } catch (e) {
      //caso produtos sejam diferentes, ai sim eu recrioos na tela de carrinho
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      //cria novo documento
      user.cartReference
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.documentID);
    }

    notifyListeners();
  }

  //atualizar toda vez que usuario alterar numero de itens
  void _onItemUpdated() {
    //atualizar quantidade de produtos
    for (final cartProduct in items) {
      //verificar quantidade de itens em um produto é menor que 0
      if (cartProduct.quantity == 0) {
        // removeFromCart(cartProduct);
      }

      _updateCartProduct(cartProduct);
    }
  }

  //remover produto do carrinho
  void removeFromCart(CartProduct cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);
    user.cartReference.document(cartProduct.id).delete();
    //remover o listener do cartProduct removido
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  Future<dynamic> removeProduct(BuildContext context) {
    return showDialog(
        context: context,
        child: AlertDialog(
          title: Text("Excluir"),
          content: Text("Deseja realmente excluir esse item?"),
          actions: [
            FlatButton(onPressed: () {}, child: Text("Não")),
            FlatButton(onPressed: () {}, child: Text("Sim")),
          ],
          elevation: 20,
          scrollable: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ));
  }

  //atualizar no firebase
  void _updateCartProduct(CartProduct cartProduct) {
    user.cartReference
        .document(cartProduct.id)
        .updateData(cartProduct.toCartItemMap());
  }

  //update user
  void updateUser(UserManager userManager) {
    user = userManager.user;
    items.clear();

    if (user != null) {
      //carregar carrinho do usuario
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async {
    //recuperar todos os documentos do cart
    final QuerySnapshot cartSnap = await user.cartReference.getDocuments();
    //mapear os documentos para pegar uma lista
    items = cartSnap.documents
        .map(
          (cart) => CartProduct.fromDocument(cart)..addListener(_onItemUpdated),
        )
        .toList();
  }
}
