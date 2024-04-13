import 'package:first_project/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_item.dart'; // Import the CartItem class from cart_item.dart

class Cart extends ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }
  void removeItemByName(String itemName) {
    _items.removeWhere((item) => item.name == itemName);
    notifyListeners(); // Notify listeners to update UI
  }
  void clearItems() {
    _items.clear();
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Cart(),
      child: XYZ(),
    ),
  );
}
