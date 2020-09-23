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

  String get formattedId => '#${orderId.padLeft(8, '0')}';

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

  //recuperar valor do firebase
  Order.fromDocument(DocumentSnapshot document) {
    orderId = document.documentID;
    //como items é um mapa de dados, mapear cada item
    items = (document.data['items'] as List<dynamic>).map((e) {
      return CartProduct.fromMap(e as Map<String, dynamic>);
    }).toList();
    price = document.data['price'] as num;
    userId = document.data['userId'] as String;
    address = Address.fromMap(document.data['address'] as Map<String, dynamic>);
    date = document.data['date'] as Timestamp;
  }

  @override
  String toString() {
    return "Orders: orderId:$orderId, Items:$items, price:$price, Address:$address";
  }
}
