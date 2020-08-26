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

  Future<void> _loadProducts() async {
    //recuperar docs
    final QuerySnapshot querySnapshot =
        await firestore.collection("Products").getDocuments();

    //converter documento para produto
    allProducts =
        querySnapshot.documents.map((d) => Product.fromDocument(d)).toList();

    notifyListeners();
  }

  //carregar todas as seções no firebase
  Future<void> _loadAllProducts() async {
    //fica lendo o banco constantemente para atualizações em tempo real
    firestore.collection('Products').snapshots().listen((snapshot) {
      //sempre que houver modificação na lista no firebase, limpar a lista antes de carrega-la
      allProducts.clear();
      //em cada documento
      for (final DocumentSnapshot document in snapshot.documents) {
        //transformar em um objeto seção
        allProducts.add(Product.fromDocument(document));
      }

      //ordenar por nome
      allProducts
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      notifyListeners();
    });
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

  //atualizar lista de produtos
  void update(Product product) {
    allProducts.removeWhere((p) => p.id == product.id);
    allProducts.add(product);
    notifyListeners();
  }
}
