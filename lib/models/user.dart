import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  //construtor
  User({this.email, this.password, this.name, this.id});

  //criar objeto com usuario logado
  User.fromDocument(DocumentSnapshot documentSnapshot) {
    name = documentSnapshot.data['name'] as String;
    email = documentSnapshot.data['email'] as String;
    id = documentSnapshot.documentID;
  }

  Firestore data = Firestore.instance;

  String id;
  String email;
  String password;
  String name;
  String passConf;

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
    };
  }
}
