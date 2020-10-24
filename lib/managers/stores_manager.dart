import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ravelinestores/models/store.dart';

class StoresManager extends ChangeNotifier {
  //construtor
  StoresManager() {
    _loadStoreList();
    _startTimer();
  }

//variaveis
  final Firestore firestore = Firestore.instance;
  List<Store> stores = [];
  Timer _timer;

//metodos
  Future<void> _loadStoreList() async {
    final snapshot = await firestore.collection('Stores').getDocuments();
    stores = snapshot.documents.map((doc) => Store.fromDocument(doc)).toList();

    notifyListeners();
  }

  //metodo para controle de horario em tempo real
  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkOpening();
    });
  }

  void _checkOpening() {
    for (final store in stores) {
      store.updateStatus();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
