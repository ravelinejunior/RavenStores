import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ravelinestores/models/section_item.dart';

class Section {
  String id;
  String name;
  String type;
  List<SectionItem> items;

  //transformar objetos do banco em objeto section
  Section.fromDocument(DocumentSnapshot documentSnapshot) {
    //id = documentSnapshot.documentID;
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
}
