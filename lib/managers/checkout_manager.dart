import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ravelinestores/managers/cart_manager.dart';
import 'package:ravelinestores/models/order.dart';
import 'package:ravelinestores/models/product.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;
  final Firestore firestore = Firestore.instance;
  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
  }

  Future<void> checkout({Function onStockFail, Function onSucess}) async {
    loading = true;
    try {
      await _decrementStock();
    } catch (e) {
      onStockFail(e);
      loading = false;
      return;
    }

    //TODO: Processar pagamento

    /* 
      CRIAR OBJETO DO PEDIDO QUE SERÁ ENVIADO PARA O FIREBASE
     */

    final orderId = await _getOrderId();

    final order = Order.fromCartManager(cartManager);
    order.orderId = orderId.toString();

    await order.save();
    cartManager.clear();

    onSucess();
    loading = false;
  }

  /* 
    usar transações
        1 -- verificar cada um dos itens do carrinho e decrementar do db
        2 -- atualizar no db o numero de itens disponiveis no estoque
        3 -- decrementar quantidade no estoque no db
        4 -- escrever novas quantidades no db
        5 -- cada pedido tera uma id unica
        6 -- pedidos devem estar em ordem
     */
  Future<void> _decrementStock() {
    return firestore.runTransaction((transaction) async {
      //criar uma lista de produtos atualizados para decrementar estoque
      final List<Product> productsToUpdate = [];
      final List<Product> productsWithoutStock = [];
      //percorrer todos os itens do carrinho
      for (final cartProduct in cartManager.items) {
        //criar um product separado pois nao se pode ter dois objetos de mesma id(tipo camisetas de tamanhos diferentes)
        Product product;
        //caso exista produto com id igual
        if (productsToUpdate
            .any((product) => product.id == cartProduct.productId)) {
          product = productsToUpdate
              .firstWhere((product) => product.id == cartProduct.productId);
        } else {
          //recuperar a referencia do produto mais atualizado
          final document = await transaction.get(
            firestore.document('Products/${cartProduct.productId}'),
          );
          //criar o objeto a partir da referencia produto
          product = Product.fromDocument(document);
        }

        cartProduct.product = product;

        //verificar se tem estoque,recuperar o itemsize do produto
        final size = product.findSize(cartProduct.size);
        if (size.stock - cartProduct.quantity < 0) {
          //FALHAR
          productsWithoutStock.add(product);
        } else {
          //decrementar no estoque
          size.stock -= cartProduct.quantity;
          productsToUpdate.add(product);
        }
      }

      //verificar se lista de produtos vazios está vazia, se nao estiver, não pode continuar com a transação
      if (productsWithoutStock.isNotEmpty)
        return Future.error(
            '${productsWithoutStock.length} produto(s) sem estoque!');

      //caso tenha estoque, passar por cada produto da lista e salvar os novos estoque no db *.exportSizeList transforma objeto tamanho em mapa
      for (final product in productsToUpdate) {
        transaction.update(
          firestore.document('Products/${product.id}'),
          {
            'sizes': product.exportSizeList(),
          },
        );
      }
    });
  }

  //função de retorno da id do pedido
  /* 
        1 -- ler valor no contador de order recuperando referencia
        2 -- atualizar order id no firebase com orderid+1 
     */
  Future<int> _getOrderId() async {
    final ref = firestore.document('Aux/ordercounter');

    try {
      final result = await firestore.runTransaction(
        (transaction) async {
          final doc = await transaction.get(ref);
          final orderId = doc.data['current'] as int;
          await transaction.update(ref, {'current': orderId + 1});
          return {'orderId': orderId};
        },
        timeout: const Duration(seconds: 10),
      );

      return result['orderId'] as int;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error("Falha ao gerar número de order id");
    }
  }
}
