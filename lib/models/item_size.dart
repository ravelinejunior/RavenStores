class ItemSize {
  //construtor
  ItemSize.fromMap(Map<String, dynamic> map) {
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  //construtor vazio
  ItemSize({this.name, this.price, this.stock});

  String name;
  num price;
  int stock;

  //verificar se existe stock
  bool get hasStock => stock > 0;

  @override
  String toString() {
    return "Item size: name:$name\nprice: $price\nstock: $stock";
  }

  //clonagem
  ItemSize clone() {
    return ItemSize(
      name: name,
      price: price,
      stock: stock,
    );
  }

  //função de conversão de lista para map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'stock': stock,
    };
  }
}
