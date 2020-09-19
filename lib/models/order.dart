import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ravelinestores/managers/cart_manager.dart';
import 'package:ravelinestores/models/address.dart';
import 'package:ravelinestores/models/cart_products.dart';

class Order {
  String orderId;

  List<CartProduct> items;
  num price;

  String userId;

  Address address;

  Timestamp date;

  final Firestore firestore = Firestore.instance;

  //construtor
  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user.id;
    address = cartManager.address;
  }

  //salvar pedido firebase
  Future<void> save() async {
    firestore.collection('Orders').document(orderId).setData({
      'orderId': orderId,
      'items': items.map((e) => e.toOrderItemMap()).toList(),
      'price': price,
      'userId': userId,
      'address': address.toMap(),
    });
  }
}
