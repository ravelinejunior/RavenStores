import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ravelinestores/models/store.dart';

class StoresManager extends ChangeNotifier {
  //construtor
  StoresManager() {
    _loadStoreList();
  }

//variaveis
  final Firestore firestore = Firestore.instance;
  List<Store> stores = [];

//metodos
  Future<void> _loadStoreList() async {
    final snapshot = await firestore.collection('Stores').getDocuments();
    stores = snapshot.documents.map((doc) => Store.fromDocument(doc)).toList();

    notifyListeners();
  }
}
