import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ravelinestores/managers/cart_manager.dart';
import 'package:ravelinestores/models/address.dart';
import 'package:ravelinestores/models/cart_products.dart';

enum Status { canceled, preparing, transporting, delivered }

class Order {
  String orderId;

  List<CartProduct> items;
  num price;

  String userId;

  Address address;

  Timestamp date;

  final Firestore firestore = Firestore.instance;
  DocumentReference get fireStoreRef =>
      firestore.collection("Orders").document(orderId);

  String get formattedId => '#${orderId.padLeft(8, '0')}';

  Status status;
  String get statusText => getStatusText(status);

  //construtor
  Order.fromCartManager(CartManager cartManager) {
    items = List.from(cartManager.items);
    price = cartManager.totalPrice;
    userId = cartManager.user.id;
    address = cartManager.address;
    status = Status.preparing;
  }

  //salvar pedido firebase
  Future<void> save() async {
    fireStoreRef.setData({
      'orderId': orderId,
      'items': items.map((e) => e.toOrderItemMap()).toList(),
      'price': price,
      'userId': userId,
      'address': address.toMap(),
      'status': status.index,
      'date': Timestamp.now(),
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

    status = Status.values[document.data['status'] as int];
  }

  //transforma enum em string para exibição
  static String getStatusText(Status status) {
    switch (status) {
      case Status.canceled:
        return 'Cancelado';
        break;
      case Status.preparing:
        return 'Em preparação para envio';
        break;
      case Status.transporting:
        return 'Em transporte';
        break;
      case Status.delivered:
        return 'Pedido entregue';
        break;
      default:
        return '';
        break;
    }
  }

  //recuar com pedido
  Function() get back {
    return (status.index >= Status.transporting.index)
        ? () {
            status = Status.values[status.index - 1];
            fireStoreRef.updateData(
              {'status': status.index},
            );
          }
        : null;
  }

  //avançar com pedido
  Function() get advance {
    return (status.index <= Status.transporting.index)
        ? () {
            status = Status.values[status.index + 1];
            fireStoreRef.updateData(
              {'status': status.index},
            );
          }
        : null;
  }

  //modificar documento de pedido requisitado e atualiza-lo
  void updateFromDocument(DocumentSnapshot doc) {
    status = Status.values[doc.data['status'] as int];
  }

  void cancel() {
    status = Status.canceled;
    fireStoreRef.updateData({'status': status.index});
  }

  @override
  String toString() {
    return "Orders: orderId:$orderId, Items:$items, price:$price, Address:$address";
  }
}
