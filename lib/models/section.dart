import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:ravelinestores/models/section_item.dart';
import 'package:uuid/uuid.dart';

class Section extends ChangeNotifier {
  String id;
  String name;
  String type;
  List<SectionItem> items;
  List<SectionItem> originalItems;

  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  DocumentReference get firestoreRef => firestore.document('Home/$id');
  StorageReference get storageRef => storage.ref().child('Home').child(id);
  String _error;
  String get error => _error;
  set error(String value) {
    _error = value;
    notifyListeners();
  }

  Section({this.id, this.name, this.type, this.items}) {
    items = items ?? [];
    originalItems = List.from(items);
  }

  //transformar objetos do banco em objeto section
  Section.fromDocument(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.documentID;
    name = documentSnapshot.data['name'] as String;
    type = documentSnapshot.data['type'] as String;
    items = (documentSnapshot.data['items'] as List)
        .map((item) => SectionItem.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  @override
  String toString() {
    return 'Section{ name: $name\ntype: $type\nitems: $items}';
  }

  //clone
  Section clone() {
    return Section(
      id: id,
      name: name,
      type: type,
      items: items.map((e) => e.clone()).toList(),
    );
  }

  // adicionar section a tela principal
  void addItem(SectionItem item) {
    items.add(item);
    notifyListeners();
  }

  // remover section a tela principal
  void removeItem(SectionItem item) {
    items.remove(item);
    notifyListeners();
  }

  //informa se seções sao validas
  bool valid() {
    /* 
      verifica se nome e items estao preenchidos
     */
    if (name == null || name.isEmpty) {
      error = 'Título vazio, digite algo!';
    } else if (items.isEmpty) {
      error = 'Insira ao menos uma imagem';
    } else {
      error = null;
    }

    return error == null;
  }

  //salvar seções no banco de dados
  Future<void> save() async {
    /* 
    1 -- criar mapa a ser enviado no bd
    2 -- verificar se seção ja existe ou se é uma nova section
    3 -- percorrer a lista de items pra verificar novas fotos ou fotos excluidas
    4 -- caso imagem seja da galeria ou camera, salvar imagem no storage
    5 -- verificação para exclusão de imagens
    6 -- salvar as urls dos itens no firestore

     */

    final Map<String, dynamic> data = {
      'name': name,
      'type': type,
    };

    if (id == null) {
      //nova seção e recuperar id
      final doc = await firestore.collection("Home").add(data);
      id = doc.documentID;
    } else {
      //updating dados
      firestoreRef.updateData(data);
    }

    for (final item in items) {
      //verificar se é uma imagem da galeria ou da camera
      if (item.image is File) {
        final StorageUploadTask task =
            storageRef.child(Uuid().v1()).putFile(item.image as File);
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL() as String;
        item.image = url;
      }
    }

    for (final original in originalItems) {
      //verificar se item ainda existe apos edição
      if (!items.contains(original)) {
        try {
          //item removido
          final ref =
              await storage.getReferenceFromUrl(original.image as String);
          await ref.delete();
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }

    //salvar no firestore
    final Map<String, dynamic> itemsData = {
      'items': items.map((e) => e.toMap()).toList()
    };
    await firestoreRef.updateData(itemsData);
  }
}
