import 'package:flutter/material.dart';
import 'pastorders.dart'; // Assuming you have an OrderHistoryPage defined in order_history_page.dart

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Profile',
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
              // Navigate to the Order History page
              Navigator.pushNamed(context, '/cart');
            },
            icon: Icon(Icons.shopping_cart), // Icon for viewing order history
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home'); // Navigate to CartPage
            },
            icon: Icon(Icons.home), // Icon for viewing cart
          ),

        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Profile picture and name
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('icons/person.jpg'), // Replace with your image asset
              ),
              SizedBox(height: 16),
              Text(
                'Guest User',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 32),
              // Button for viewing order history
              ElevatedButton(
                onPressed: () {
                  // Navigate to the Order History page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderHistoryPage()),
                  );
                },
                child: Text('Order History'),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}