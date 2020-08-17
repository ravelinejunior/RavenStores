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

  //pesquisa
  String _search = '';
  //criar get e set pois preciso notificar a alteração
  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  //lista de produtos com pesquisa
  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];

    if (search.isEmpty) {
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(allProducts
          .where((p) => p.name.toLowerCase().contains(search.toLowerCase())));
    }

    return filteredProducts;
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

  //pesquisar produto por id
  Product findProductbyId(String id) {
    //procurar produto
    try {
      return allProducts.firstWhere((p) => p.id == id);
    } catch (e) {
      //caso produto nao seja encontrado
      return null;
    }
  }
}
