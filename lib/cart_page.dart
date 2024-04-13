import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_project/cart_provider.dart';
import 'package:first_project/cart_item.dart';
import 'package:first_project/order_summary_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'order_summary.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late double totalPrice;
  late String formattedDate;
  List<CartItem> itemList = [];
  bool orderPlaced = false;

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now()); // Initialize formattedDate
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    // Create a Map to consolidate items by name and calculate total quantity and price
    final Map<String, CartItem> consolidatedItems = {};
    for (final item in cart.items) {
      if (consolidatedItems.containsKey(item.name)) {
        consolidatedItems[item.name]?.quantity += item.quantity;
        consolidatedItems[item.name]?.price += item.price; // Add the price of each individual item
      } else {
        consolidatedItems[item.name] = CartItem(item.name, item.quantity, item.price);
      }
    }

    // Convert the consolidated items Map to a List
    itemList = consolidatedItems.values.toList();
    totalPrice = itemList.fold(0, (previous, current) => previous + current.price);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Cart',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange[600], // Change app bar color to orange[600]
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)), // Add rounded corners
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home'); // Navigate to CartPage
            },
            icon: Icon(Icons.home), // Icon for viewing cart
          ),
        ],
      ),
      body: Visibility(
        visible: !orderPlaced,
        child: itemList.isEmpty
            ? Center(
          child: Text(
            'Your cart is empty',
            style: TextStyle(color: Colors.grey),
          ),
        )
            : Padding(
          padding: const EdgeInsets.only(top: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue),
                dataRowColor: MaterialStateColor.resolveWith((states) => Colors.grey[300] ?? Colors.grey),
                columns: [
                  DataColumn(
                    label: Text(
                      'Product',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Qty.',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Price',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
                rows: () {
                  List<DataRow> rows = itemList.map((item) {
                    return DataRow(cells: [
                      DataCell(
                        Row(
                          children: [
                            Text(
                              item.name.toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Remove the item from the cart
                                setState(() {
                                  cart.removeItemByName(item.name); // Assuming `cart` is an instance of your CartProvider class
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      DataCell(
                        Text(
                          item.quantity.toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      DataCell(
                        Text(
                          item.price.toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ]);
                  }).toList();

                  // Add the extra row for total price
                  rows.add(DataRow(
                    cells: [
                      DataCell(
                        Text(
                          'Total Price',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      DataCell(Text('')),
                      DataCell(
                        Text(
                          totalPrice.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ],
                  ));

                  return rows;
                }(),
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            if (itemList.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Your cart is empty!'),
                ),
              );
            } else {
              saveOrderHistory(formattedDate, itemList, totalPrice);
              Provider.of<Cart>(context, listen: false).clearItems();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Order placed!'),
                ),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderSummaryPage(cartItems: itemList),
                ),
              );
            }
          },
          child: Text('Place Order'),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
  Future<void> saveOrderHistory(String formattedDate, List<CartItem> cartItems, double totalPrice) async {
    OrderSummary orderSummary = OrderSummary(
      date: formattedDate,
      cartItems: cartItems,
      totalPrice: totalPrice,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> orderSummaries = prefs.getStringList('orderSummaries') ?? [];
    orderSummaries.add(jsonEncode(orderSummary.toMap()));
    await prefs.setStringList('orderSummaries', orderSummaries);
  }
}