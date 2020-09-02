import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ravelinestores/models/section.dart';

class HomeManager extends ChangeNotifier {
  final Firestore firestore = Firestore.instance;
  final List<Section> _sections = [];
  bool editing = false;
  List<Section> _editingSections = [];

  HomeManager() {
    _loadSections();
  }

  //carregar todas as seções no firebase
  Future<void> _loadSections() async {
    //fica lendo o banco constantemente para atualizações em tempo real
    firestore.collection('Home').snapshots().listen((snapshot) {
      //sempre que houver modificação na lista no firebase, limpar a lista antes de carrega-la
      _sections.clear();
      //em cada documento
      for (final DocumentSnapshot document in snapshot.documents) {
        //transformar em um objeto seção
        _sections.add(Section.fromDocument(document));
      }
      notifyListeners();
    });
  }

  //get e set pra ver se está em modo de edição ou nao
  List<Section> get sections {
    if (editing)
      return _editingSections;
    else
      return _sections;
  }

  //modo de edição
  void enterEditing() {
    editing = true;
    _editingSections = _sections.map((s) => s.clone()).toList();
    notifyListeners();
  }

  //salvar edição
  Future<void> saveEditing() async {
    /*
      passar por todas as seções e chamar a função valid

      caso algum dos campos nao seja valido, setar variavel valid como false
      */
    //verificar se todos os dados são validos
    bool valid = true;
    for (final section in _editingSections) {
      if (!section.valid()) valid = false;
    }

    if (!valid) return;

    //percorre as seções e salva no banco
    for (final section in _editingSections) {
      await section.save();
    }
    editing = false;
    notifyListeners();
  }

  //descartar edição
  void discardEditing() {
    editing = false;
    notifyListeners();
  }

  //adicionar section
  void addSection(Section section) {
    _editingSections.add(section);
    notifyListeners();
  }

  //remover section
  void removeSection(Section section) {
    _editingSections.remove(section);
    notifyListeners();
  }
}
