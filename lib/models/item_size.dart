class ItemSize {
  //construtor
  ItemSize.fromMap(Map<String, dynamic> map) {
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  String name;
  num price;
  int stock;

  //verificar se existe stock
  bool get hasStock => stock > 0;

  @override
  String toString() {
    // TODO: implement toString
    return "Item size: name:$name\nprice: $price\nstock: $stock";
  }
}
