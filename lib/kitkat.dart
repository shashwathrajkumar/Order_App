import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'cart_item.dart';

class Kitkat extends StatefulWidget {
  @override
  _KitKatState createState() => _KitKatState();
}

class _KitKatState extends State<Kitkat> {
  int quantity = 1;
  double price = 20.0; // Initial price

  @override
  Widget build(BuildContext context) {
    double totalPrice = quantity * price; // Calculate total price

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KitKat Regular',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange[600], // Set app bar color to orange[600]
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Set rounded corners
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home'); // Navigate to CartPage
            },
            icon: Icon(Icons.home), // Icon for viewing cart
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart'); // Navigate to CartPage
            },
            icon: Icon(Icons.shopping_cart), // Icon for viewing cart
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        // Adjust the padding as needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // Align children in the center horizontally
          children: [
            SizedBox(height: 20), // Adjust the height as needed
            Align(
              alignment: Alignment.topCenter,
              // Align the image to the top center
              child: Image.asset(
                'icons/kitkat-regular.jpg',
                // Replace this with your image asset path
                width: 140, // Adjust the width as needed
                height: 140, // Adjust the height as needed
                fit: BoxFit.contain, // Adjust the fit as needed
              ),
            ),
            SizedBox(height: 20), // Adjust the height as needed
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('KitKat Regular  Netwt. 40g')
              ],
            ),
            SizedBox(height: 10), // Adjust the height as needed
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // Decrease the quantity if greater than 0
                        if (quantity > 0) {
                          quantity--;
                        }
                      });
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(1),
                        // Adjust the padding as needed
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Set background color to white
                    ),
                    child: Icon(Icons.remove, size: 20,), // Change the icon to a minus sign
                  ),
                ),
                SizedBox(width: 10), // Adjust the width as needed
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0), // Add padding to the right
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0), // Adjust padding as needed
                    child: Text(
                      '$quantity',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 30,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // Increase the quantity
                        quantity++;
                      });
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(1),
                        // Adjust the padding as needed
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Set background color to white
                    ),
                    child: Icon(Icons.add, size: 20,),
                  ),
                ),

                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${quantity} KitKat added to cart!'),
                    ));
                    context.read<Cart>().addItem(CartItem(
                        "KitKat", quantity, totalPrice)); // Example item
                    setState(() {
                      quantity = 1;
                    });
                  },
                  child: Text("Add to Cart"),
                ),

              ],
            ),
            SizedBox(height: 10), // Add spacing between text and price
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Price: Rs. $totalPrice'), // Display the total price
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Other variations:'),
              ],
            ),
            SizedBox(height: 10), // Adjust the height as needed
            GridView.count(
              crossAxisCount: 2, // Display two products in each row
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Disable scrolling
              children: [
                buildProductButton('KitKat Dark', 'icons/kitkatdark.jpg'),
                buildProductButton('KitKat Crispy Creamy', 'icons/kitkat-crispycreamy.jpg'),
                buildProductButton('KitKat Packet', 'icons/kitkat-packet.jpeg'),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget buildProductButton(String productName, String imagePath) {
    return Column(
      children: [
        SizedBox(height: 10), // Adjust the height as needed
        ElevatedButton(
          onPressed: () {
            switch(productName) {
              case "KitKat Dark":
                Navigator.pushNamed(context, '/kitkatdark');
                break;
              case "KitKat Crispy Creamy":
                Navigator.pushNamed(context, '/kitkatcrispy');
                break;
              case "KitKat Packet":
                Navigator.pushNamed(context, '/kitkatpacket');
            }


          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Colors.white), // Set background color to white
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 0.5, right: 0.5),
            child: Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          productName,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}