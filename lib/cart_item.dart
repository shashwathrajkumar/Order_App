class CartItem {
  String name;
  int quantity;
  double price;

  CartItem(this.name, this.quantity, this.price);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      map['name'],
      map['quantity'],
      map['price'],
    );
  }
}