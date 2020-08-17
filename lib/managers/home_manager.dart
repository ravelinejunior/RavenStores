import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ravelinestores/models/section.dart';

class HomeManager extends ChangeNotifier {
  final Firestore firestore = Firestore.instance;
  List<Section> sections = [];

  HomeManager() {
    _loadSections();
  }

  //carregar todas as seções no firebase
  Future<void> _loadSections() async {
    //fica lendo o banco constantemente para atualizações em tempo real
    firestore.collection('Home').snapshots().listen((snapshot) {
      //sempre que houver modificação na lista no firebase, limpar a lista antes de carrega-la
      sections.clear();
      //em cada documento
      for (final DocumentSnapshot document in snapshot.documents) {
        //transformar em um objeto seção
        sections.add(Section.fromDocument(document));
      }
      notifyListeners();
    });
  }
}
