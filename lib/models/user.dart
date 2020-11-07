import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ravelinestores/models/address.dart';

class User {
  //construtor
  User({this.email, this.password, this.name, this.id});

  //referencia do cart Firestore
  CollectionReference get cartReference => firestoreRef.collection('cart');

  //referencia do tokens Firestore
  CollectionReference get tokenReference => firestoreRef.collection('token');

  //criar objeto com usuario logado
  User.fromDocument(DocumentSnapshot documentSnapshot) {
    name = documentSnapshot.data['name'] as String;
    email = documentSnapshot.data['email'] as String;
    id = documentSnapshot.documentID;
    if (documentSnapshot.data.containsKey('address')) {
      address = Address.fromMap(
          documentSnapshot.data['address'] as Map<String, dynamic>);
    }
  }

  Firestore data = Firestore.instance;

  String id;
  String email;
  String password;
  String name;
  String passConf;
  bool admin = false;
  Address address;

  //criar referencia ao no de usuario
  DocumentReference get firestoreRef => data.document('Users/$id');

  Future<void> saveData() async {
    await firestoreRef.setData(toMap());
  }

  //função que retorna mapa de cadastro de usuario
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      if (address != null) 'address': address.toMap(),
    };
  }

  //função para salvar novo endereço por usuario
  Future<void> setAddress(Address address) async {
    this.address = address;
    saveData();
  }

  //salvar token usuario
  Future<void> saveToken() async {
    final token = await FirebaseMessaging().getToken();
    await tokenReference.document(token).setData({
      'token': token,
      'updatedAt': FieldValue.serverTimestamp(),
      'platform': Platform.operatingSystem,
    });
  }
}
