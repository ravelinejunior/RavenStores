import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:ravelinestores/managers/user_manager.dart';
import 'package:ravelinestores/models/user.dart';

class AdminUsersManager extends ChangeNotifier {
  //attr
  List<User> users = [];
  final Firestore firestore = Firestore.instance;
  StreamSubscription _subscription;

  void updateUsersManager(UserManager userManager) {
    //caso usuario nao seja admin, limpar o background do snapshot, economia de memoria
    _subscription?.cancel();
    if (userManager.adminEnabled) {
      //ficar escutando se existem novos usuarios
      _listenToUsers();
    } else {
      //caso usuario logado nao seja admin
      users.clear();
      notifyListeners();
    }
  }

//escuta usuarios adicionados
  void _listenToUsers() {
    //firebase datas
    _subscription =
        firestore.collection("Users").snapshots().listen((snapshot) {
      users = snapshot.documents.map((e) => User.fromDocument(e)).toList();
      //ordenar usuarios por nome
      users
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      notifyListeners();
    });
  }

  //recuperar nomes
  List<String> get names => users.map((e) => e.name).toList();

  //matar a função listener quando nao estiver na tela para otimizar desempenho
  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

/*  const faker = Faker();
    //criar usuarios com dados falsos
    for (int i = 0; i < 1000; i++) {
      users.add(User(
        name: faker.person.name(),
        email: faker.internet.email(),
      ));
    } */
