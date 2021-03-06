import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ravelinestores/models/item_size.dart';
import 'package:ravelinestores/models/product.dart';

class CartProduct extends ChangeNotifier {
  Product _product;
  Product get product => _product;
  set product(Product value) {
    _product = value;
    notifyListeners();
  }

  Firestore firestore = Firestore.instance;

  String productId;
  String id;
  String size;
  int quantity;
  num fixedPrice;

  //construtor
  CartProduct.fromProduct(this._product) {
    productId = product.id;
    size = product.selectedSize.name;
    quantity = 1;
  }

  CartProduct.fromDocument(DocumentSnapshot doc) {
    productId = doc.data['pid'] as String;
    size = doc.data['size'] as String;
    quantity = doc.data['quantity'] as int;
    id = doc.documentID;

//recuperar o produto com o id selecionado
    firestore.document('Products/$productId').get().then(
      (doc) {
        product = Product.fromDocument(doc);
      },
    );
  }

  //recuperar items em formato mapa
  CartProduct.fromMap(Map<String, dynamic> map) {
    productId = map['pid'] as String;
    quantity = map['quantity'] as int;
    size = map['size'] as String;
    fixedPrice = map['fixedPrice'] as num;

    firestore.document('Products/$productId').get().then((doc) {
      product = Product.fromDocument(doc);
    });
  }

  //verificar se é stackable
  bool stackable(Product product) {
    return product.id == productId && product.selectedSize.name == size;
  }

  // incrementar quantidade de produtos
  Future<void> incrementQuantity() async {
    await quantity++;
    notifyListeners();
  }

  // remover quantidade de produtos
  Future<void> removeQuantity() async {
    if (quantity > 1) await quantity--;
    notifyListeners();
  }

  //zerar produtos
  Future<void> zeroProducts() async {
    quantity = -1;
    notifyListeners();
  }

//criar os getters de acesso para recuperar o preço
  ItemSize get itemSize {
    if (product == null) return null;
    return product.findSize(size);
  }

  //verificar stock
  bool get hasStock {
    final size = itemSize;
    if (size == null) return false;
    return size.stock >= quantity;
  }

  //buscar preço tamanho
  num get unitPrice {
    if (product == null) return 0;
    return itemSize?.price ?? 0;
  }

  //salvar dados no firebase
  Map<String, dynamic> toCartItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
    };
  }

  //getter do preço total
  num get totalPrice => unitPrice * quantity;

  //transforma objeto em mapa
  Map<String, dynamic> toOrderItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
      'fixedPrice': fixedPrice ?? unitPrice,
    };
  }
}
