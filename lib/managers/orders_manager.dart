import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ravelinestores/models/order.dart';
import 'package:ravelinestores/models/user.dart';

class OrdersManager extends ChangeNotifier {
  User user;
  List<Order> orders = [];
  final Firestore firestore = Firestore.instance;
  StreamSubscription _streamSubscription;
//salvar e atualizar usuario
  void updateUser(User user) {
    this.user = user;
    orders.clear();
    _streamSubscription?.cancel();

    if (user != null) {
      _listenToOrders();
    }
  }

  //verifica e escuta se existem novos pedidos
  void _listenToOrders() {
    /* 
      percorrer todos os pedidos cujo usuario tem id passada
      streamSubscription para poder finalizar o listen quando app fechar ...
     */

    _streamSubscription = firestore
        .collection('Orders')
        .where('userId', isEqualTo: user.id)
        .snapshots()
        .listen(
      (orderSnap) {
        orders.clear();
        //obter novo pedido de cada documento (de mapa para objeto)
        for (final document in orderSnap.documents) {
          orders.add(Order.fromDocument(document));
        }
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription?.cancel();
  }
}
