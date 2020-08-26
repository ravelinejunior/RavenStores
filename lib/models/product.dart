import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ravelinestores/models/item_size.dart';
import 'package:uuid/uuid.dart';

class Product extends ChangeNotifier {
  String id;
  String name;
  String description;
  List images;
  List<ItemSize> sizesList;
  List<dynamic> newImages;
  bool _loading = false;

//get e set loading
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  //dbs
  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  DocumentReference get firestoreRef => firestore.document('Products/$id');
  StorageReference get storageRef => storage.ref().child('Products').child(id);

  Product({this.id, this.name, this.description, this.images, this.sizesList}) {
    /* 
      quando construtor vazio for chamado, as listas devem ser inicializadas
      caso lista nao seja vazia, passar a propria instancia da lista, caso seja passar vazio
     */

    images = images ?? [];
    sizesList = sizesList ?? [];
  }

  //criar um get/set para o tamanho selecionado
  ItemSize _selectedSize;

  ItemSize get selectedSize => _selectedSize;

  set selectedSize(ItemSize item) {
    _selectedSize = item;
    notifyListeners();
  }

  //recuperar o tamanho com os dados
  ItemSize findSize(String name) {
    //caso tamanho seja removido
    try {
      return sizesList.firstWhere((size) => size.name == name);
    } catch (e) {
      return null;
    }
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

  //preço base
  num get basePrice {
    //percorrer todos os tamanhos e retornar o valor menor
    num lowest = double.infinity;
    for (final size in sizesList) {
      if (size.price < lowest && size.hasStock) lowest = size.price;
    }
    notifyListeners();
    return lowest;
  }

  //metodo de clonagem de produto
  Product clone() {
    return Product(
      id: id,
      name: name,
      description: description,
      /* 
        duplicar lista de imagens a partir das imagens ja cadastradas
        pegar cada tamanho e transformar em uma lista
       */
      images: List.from(images),
      sizesList: sizesList.map((size) => size.clone()).toList(),
    );
  }

  //função para salvar dados no firebase
  Future<void> save() async {
    loading = true;

    final Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'sizes': exportSizeList(),
    };

    //verificar se produto ja existe ou se é um novo produto
    if (id == null) {
      //criando produto e recuperando sua id
      final doc = await firestore.collection('Products').add(data);
      id = doc.documentID;
    } else {
      await firestoreRef.updateData(data);
    }

    //metodologia de adição de foto, ou update com newfotos ou adição com os files
    final List<String> updateImage = [];

    for (final newImage in newImages) {
      //caso imagem esteja contida
      if (images.contains(newImage))
        updateImage.add(newImage as String);
      //caso imagem não esteja contida, será enviada para storage.
      else {
        //gerar id aleatorio
        final StorageUploadTask task =
            storageRef.child(Uuid().v1()).putFile(newImage as File);

        final StorageTaskSnapshot snapshot = await task.onComplete;
        //obter url
        final String url = await snapshot.ref.getDownloadURL() as String;
        updateImage.add(url);
      }
    }

    //condição de verificação de existencia de imagens no new images
    for (final image in images) {
      if (!newImages.contains(image)) {
        try {
          final ref = await storage.getReferenceFromUrl(image as String);
          await ref.delete();
        } catch (e) {
          debugPrint('falha ao deletar $image');
        }
      }
    }

    //salvar a lista
    await firestoreRef.updateData({'images': updateImage});
    images = updateImage;
    loading = false;
  }

  //converter lista de sizes em map para interpretação do firebase e retornar uma lista dos mapas
  List<Map<String, dynamic>> exportSizeList() {
    return sizesList.map((size) => size.toMap()).toList();
  }
}
