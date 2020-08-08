import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ravelinestores/models/item_size.dart';

class Product extends ChangeNotifier {
  String id;
  String name;
  String description;
  List<String> images;
  List<ItemSize> sizesList;

  //criar um get/set para o tamanho selecionado
  ItemSize _selectedSize;

  ItemSize get selectedSize => _selectedSize;

  set selectedSize(ItemSize item) {
    _selectedSize = item;
    notifyListeners();
  }

//verificar se existe stock geral
  int get totalStock {
    int stock = 0;
    for (final size in sizesList) {
      stock += size.stock;
    }

    return stock;
  }

  bool get hasStock => totalStock > 0;

//recuperar dados do documento
  Product.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document['images'] as List<dynamic>);
    sizesList = (document.data['sizes'] as List<dynamic> ?? [])
        .map(
          (s) => ItemSize.fromMap(s as Map<String, dynamic>),
        )
        .toList();
  }
}
