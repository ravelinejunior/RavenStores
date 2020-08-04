import 'package:cloud_firestore/cloud_firestore.dart';

class ProductManager {
  final Firestore firestore = Firestore.instance;
  //gerenciador de produtos do firebase
  ProductManager() {
    //carregar todos os produtos
    _loadAllProducts();
  }

  Future<void> _loadAllProducts() async {
    //recuperar docs
    final QuerySnapshot querySnapshot =
        await firestore.collection("Products").getDocuments();

    for (DocumentSnapshot doc in querySnapshot.documents) {
      print(doc.data);
    }
  }
}
