import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'order_summary.dart';
import 'order_summary_page.dart';

class OrderHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order History',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange[600], // Set background color to orange[600]
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Add rounded corners
          ),
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
      backgroundColor: Colors.white, // Set background color to white
      body: FutureBuilder<List<OrderSummary>>(
        future: _getOrderSummaries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<OrderSummary> orderSummaries = snapshot.data ?? [];
            if (orderSummaries.isEmpty) {
              return Center(
                child: Text(
                  'No previous orders',
                  style: TextStyle(color: Colors.grey), // Grey text style
                ),
              );
            } else {
              return ListView.builder(
                itemCount: orderSummaries.length,
                itemBuilder: (context, index) {
                  OrderSummary orderSummary = orderSummaries[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the order summary page with the selected order summary data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderSummaryPage(cartItems: orderSummary.cartItems),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Background color for the container
                        borderRadius: BorderRadius.circular(8), // Rounded corners for the container
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Margin around the container
                      child: ListTile(
                        title: Text('Order Date: ${orderSummary.date}'),
                        subtitle: Text('Total Price: Rs.${orderSummary.totalPrice}'),
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
        // builder: (context, snapshot) {
        //   if (snapshot.connectionState == ConnectionState.waiting) {
        //     return Center(child: CircularProgressIndicator());
        //   } else if (snapshot.hasError) {
        //     return Center(child: Text('Error: ${snapshot.error}'));
        //   } else {
        //     List<OrderSummary> orderSummaries = snapshot.data ?? [];
        //     return ListView.builder(
        //       itemCount: orderSummaries.length,
        //       itemBuilder: (context, index) {
        //         OrderSummary orderSummary = orderSummaries[index];
        //         return GestureDetector(
        //           onTap: () {
        //             // Navigate to the order summary page with the selected order summary data
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => OrderSummaryPage(cartItems: orderSummary.cartItems),
        //               ),
        //             );
        //           },
        //           child: Container(
        //             decoration: BoxDecoration(
        //               color: Colors.grey[200], // Background color for the container
        //               borderRadius: BorderRadius.circular(8), // Rounded corners for the container
        //             ),
        //             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Margin around the container
        //             child: ListTile(
        //               title: Text('Order Date: ${orderSummary.date}'),
        //               subtitle: Text('Total Price: Rs.${orderSummary.totalPrice}'),
        //             ),
        //           ),
        //         );
        //       },
        //     );
        //   }
        // },
      ),
    );
  }

  Future<List<OrderSummary>> _getOrderSummaries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> orderSummaryJsonList = prefs.getStringList('orderSummaries') ?? [];
    List<OrderSummary> orderSummaries = orderSummaryJsonList.map((jsonString) => OrderSummary.fromMap(jsonDecode(jsonString))).toList();
    return orderSummaries;
  }
}