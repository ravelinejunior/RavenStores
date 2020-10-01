import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ravelinestores/models/order.dart';
import 'package:ravelinestores/models/user.dart';

class AdminOrdersManager extends ChangeNotifier {
  User user;
  User userFiltered;
  final List<Order> _orders = [];
  final Firestore firestore = Firestore.instance;
  StreamSubscription _streamSubscription;
  List<Status> statusFiltered = [Status.preparing, Status.transporting];

  List<Order> get filteredOrders {
    List<Order> output = _orders.reversed.toList();

    if (userFiltered != null) {
      output =
          output.where((order) => order.userId == userFiltered.id).toList();
    }

    return output =
        output.where((order) => statusFiltered.contains(order.status)).toList();
  }

//salvar e atualizar usuario
  void updateUserAdmin({bool adminEnabled}) {
    _orders.clear();
    _streamSubscription?.cancel();

    if (adminEnabled) {
      _listenToOrders();
    }
  }

  //verifica e escuta se existem novos pedidos
  void _listenToOrders() {
    /* 
      percorrer todos os pedidos cujo usuario tem id passada
      streamSubscription para poder finalizar o listen quando app fechar ...
     */

    _streamSubscription = firestore.collection('Orders').snapshots().listen(
      (orderSnap) {
        for (final changeDoc in orderSnap.documentChanges) {
          switch (changeDoc.type) {
            case DocumentChangeType.added:
              _orders.add(Order.fromDocument(changeDoc.document));
              break;
            case DocumentChangeType.modified:
              final modOrder = _orders.firstWhere(
                (order) => order.orderId == changeDoc.document.documentID,
              );
              modOrder.updateFromDocument(changeDoc.document);
              break;
            case DocumentChangeType.removed:
              break;
          }
        }

        notifyListeners();
      },
    );
  }

  void setUserFilter(User user) {
    userFiltered = user;
    notifyListeners();
  }

  void setStatusFilter({Status status, bool enabled}) {
    if (enabled) {
      //caso estado habilitado, adicionar a lista
      statusFiltered.add(status);
    } else {
      statusFiltered.remove(status);
    }

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription?.cancel();
  }
}
