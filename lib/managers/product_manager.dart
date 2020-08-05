import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ravelinestores/models/product.dart';

class ProductManager extends ChangeNotifier {
  final Firestore firestore = Firestore.instance;
  //gerenciador de produtos do firebase
  ProductManager() {
    //carregar todos os produtos
    _loadAllProducts();
  }

  //lista de produtos
  List<Product> allProducts = [];

  Future<void> _loadAllProducts() async {
    //recuperar docs
    final QuerySnapshot querySnapshot =
        await firestore.collection("Products").getDocuments();

    //converter documento para produto
    allProducts =
        querySnapshot.documents.map((d) => Product.fromDocument(d)).toList();

    notifyListeners();
  }
}
