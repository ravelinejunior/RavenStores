import 'package:flutter/cupertino.dart';
import 'package:ravelinestores/managers/cart_manager.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;

  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
  }

  void checkout() {
    _decrementStock();
  }

  void _decrementStock() {
    /* 
        1 -- verificar cada um dos itens do carrinho e decrementar do db
        2 -- atualizar no db o numero de itens disponiveis no estoque
        3 -- decrementar quantidade no estoque no db
        4 -- escrever novas quantidades no db
     */
  }
}
