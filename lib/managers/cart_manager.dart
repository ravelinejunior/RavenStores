import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ravelinestores/managers/user_manager.dart';
import 'package:ravelinestores/models/address.dart';
import 'package:ravelinestores/models/cart_products.dart';
import 'package:ravelinestores/models/product.dart';
import 'package:ravelinestores/models/user.dart';
import 'package:ravelinestores/services/cep_aberto_service.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> items = [];
  User user;
  num productsPrice = 0;
  num deliveryPrice;
  Address address;
  Firestore _firestore = Firestore.instance;

  //carregamento get - set
  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  num get totalPrice => productsPrice + (deliveryPrice ?? 0);

  //ADD PRODUCTS
  void addToCart(Product product) {
    try {
      //empilhar produtos iguais
      final stack = items.firstWhere((p) => p.stackable(product));
      stack.incrementQuantity();
    } catch (e) {
      //caso produtos sejam diferentes, ai sim eu recrioos na tela de carrinho
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      //cria novo documento
      user.cartReference
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.documentID);

      //atualizar tela sempre que adicionar produto
      _onItemUpdated();
    }

    notifyListeners();
  }

  //atualizar toda vez que usuario alterar numero de itens
  void _onItemUpdated() {
    productsPrice = 0.0;

    //atualizar quantidade de produtos
    for (int i = 0; i < items.length; i++) {
      final cartProduct = items[i];
      //verificar quantidade de itens em um produto é menor que 0
      if (cartProduct.quantity == -1) {
        removeFromCart(cartProduct);

        //remover um indice para remontar a tela
        i--;
        continue;
      }

      //atualizar preço
      productsPrice += cartProduct.totalPrice;

      _updateCartProduct(cartProduct);
      notifyListeners();
    }
  }

  //remover produto do carrinho
  void removeFromCart(CartProduct cartProduct) {
    items.removeWhere((p) => p.id == cartProduct.id);
    user.cartReference.document(cartProduct.id).delete();
    cartProduct.quantity = 0;
    //remover o listener do cartProduct removido
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  //atualizar no firebase
  void _updateCartProduct(CartProduct cartProduct) {
    if (cartProduct.id != null)
      user.cartReference
          .document(cartProduct.id)
          .updateData(cartProduct.toCartItemMap());
  }

  //update user
  void updateUser(UserManager userManager) {
    user = userManager.user;
    productsPrice = 0.0;
    items.clear();
    removeAddress();

    if (user != null) {
      //carregar carrinho do usuario
      _loadCartItems();
      //carregar endereço do usuario
      _loadUserAddress();
    }
  }

  //recuperar valores do address
  Future<void> _loadUserAddress() async {
    //verifica se é nulo e ja calcula raio de entrega
    if (user.address != null &&
        await calculateDelivery(user.address.lat, user.address.long)) {
      this.address = user.address;
      notifyListeners();
    }
  }

//recuperar todos os documentos do cart
  Future<void> _loadCartItems() async {
    //recuperar todos os documentos do cart
    final QuerySnapshot cartSnap = await user.cartReference.getDocuments();
    //mapear os documentos para pegar uma lista
    items = cartSnap.documents
        .map(
          (cart) => CartProduct.fromDocument(cart)..addListener(_onItemUpdated),
        )
        .toList();
  }

  //verificar se carrinho é valido ou nao
  bool get isCartValid {
    //verificar cada cartProduct
    for (final cartProduct in items) {
      if (!cartProduct.hasStock) return false;
    }

    return true;
  }

  //ADDRESSES
  Future<void> getAddress(String cep) async {
    /* 
    1 -- recuperar o service com o cep digitado
     */

    loading = true;

    final cepService = CepAbertoService();
    try {
      final cepAdress = await cepService.getAddressFromCep(cep);
      if (cepAdress != null) {
        address = Address(
          street: cepAdress.logradouro,
          district: cepAdress.bairro,
          zipCode: cepAdress.cep,
          city: cepAdress.cidade.nome,
          state: cepAdress.estado.sigla,
          complement: cepAdress.complemento,
          lat: cepAdress.latitude,
          long: cepAdress.longitude,
          alt: cepAdress.altitude,
        );
        //notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
      loading = false;
      return Future.error("Favor, digitar um cep válido!");
    }

    loading = false;
  }

  //remover o address e avisar o listener que ele ficou nulo
  void removeAddress() {
    address = null;
    deliveryPrice = null;
    notifyListeners();
  }

  //salvar address e calcular distancia
  Future<void> setAddress(Address address) async {
    loading = true;
    /* 
     1 -  salvar address passado no address geral
     2 - passar address para o calculo de delivery
     */
    this.address = address;
    if (await calculateDelivery(address.lat, address.long)) {
      user.setAddress(address);
      //notifyListeners();
      loading = false;
    } else {
      loading = false;
      return Future.error("Endereço fora do raio de entrega :(");
    }
  }

  //função de calculo de frete
  Future<bool> calculateDelivery(double lat, double long) async {
    /* 
      verificar ponto de referencia inicial, buscado do firebase, da loja no caso
      buscar long e lat da collection aux criada
      converter distancia de metros em km
      calculo de preço delivery sera feito : calc = preço fixo firebase + distancia * 50cents

     */

    final DocumentSnapshot doc =
        await _firestore.document('Aux/delivery').get();
    final latStore = doc.data['lat'] as double;
    final longStore = doc.data['long'] as double;
    final maxKm = doc.data['maxKm'] as num;
    final kmPrice = doc.data['km'] as num;
    final base = doc.data['base'] as num;

    double dis =
        await Geolocator().distanceBetween(latStore, longStore, lat, long);

    dis /= 1000.0;

    if (dis <= maxKm) {
      deliveryPrice = base + (dis * kmPrice);
      return true;
    } else {
      return false;
    }
  }

  //verificar se address é valido e frete foi calculado com sucesso
  bool get isAddressValid => address != null && deliveryPrice != null;
}
