import 'cart_item.dart';
class OrderSummary {
  final String date;
  final List<CartItem> cartItems;
  final double totalPrice;

  OrderSummary({
    required this.date,
    required this.cartItems,
    required this.totalPrice,
  });

  // Convert OrderSummary object to a map
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'cartItems': cartItems.map((item) => item.toMap()).toList(),
      'totalPrice': totalPrice,
    };
  }

  // Create OrderSummary object from a map
  factory OrderSummary.fromMap(Map<String, dynamic> map) {
    return OrderSummary(
      date: map['date'],
      cartItems: List<CartItem>.from(map['cartItems'].map((itemMap) => CartItem.fromMap(itemMap))),
      totalPrice: map['totalPrice'],
    );
  }
}