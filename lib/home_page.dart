import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> products = [
    {'name': 'DairyMilk', 'image': 'icons/dairymilk-regular.jpg', 'route': '/dairymilk'},
    {'name': 'Perk', 'image': 'icons/perk-regular.jpg', 'route': '/perk'},
    {'name': 'KitKat', 'image': 'icons/kitkat-regular.jpg', 'route': '/kitkat'},
    {'name': 'Munch', 'image': 'icons/munch-regular.jpg', 'route': '/munch'},
    {'name': 'Fivestar', 'image': 'icons/fivestar-regular.jpg', 'route': '/fivestar'},
    {'name': 'DairyMilk 165g', 'image': 'icons/dairymilk-165g.jpg', 'route': '/dairymilk165'},
    {'name': 'DairyMilk Silk Bubbly', 'image': 'icons/dairymilk-silk-bubbly.jpeg', 'route': '/dairymilkbubbly'},
    {'name': 'DairyMilk Silk', 'image': 'icons/dairymilk-silk-regular.jpg', 'route': '/dairymilksilk'},
    {'name': 'DairyMilk Silk Fruit n Nut', 'image':'icons/dairymilk-silk-fruitnut.jpg', 'route': '/dairymilkfn'},
    {'name': 'Fivestar 3D', 'image':'icons/fivestar-3D.jpg', 'route': '/fivestar3D'},
    {'name': 'Fivestar Oreo', 'image':'icons/fivestar-oreo.jpg', 'route': '/fivestaroreo'},
    {'name': 'Fivestar Packet', 'image':'icons/fivestarpacket.jpg', 'route': '/fivestarpacket'},
    {'name': 'KitKat Dark', 'image':'icons/kitkatdark.jpg', 'route': '/kitkatdark'},
    {'name': 'KitKat Crispy Creamy', 'image':'icons/kitkat-crispycreamy.jpg', 'route': '/kitkatcrispy'},
    {'name': 'KitKat Packet', 'image':'icons/kitkat-packet.jpeg', 'route': '/kitkatpacket'},
    {'name': 'Munch Max', 'image':'icons/munch-max.jpg', 'route': '/munchmax'},
    {'name': 'Munch Packet', 'image':'icons/munch-packet.jpg', 'route': '/munchpacket'},
    {'name': 'Munch Nuts', 'image':'icons/munch-nuts.jpg', 'route': '/munchnuts'},
    {'name': 'Perk Double', 'image':'icons/perk-double.jpg', 'route': '/perkdouble'},
    {'name': 'Perk Packet', 'image':'icons/perk-packet.jpeg', 'route': '/perkpacket'},
    // Add more products here with their respective image paths and routes
  ];
  List<Map<String, String>> filteredProducts = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    filteredProducts = List.from(products);
    super.initState();
  }

  void filterProducts(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredProducts = products
            .where((product) => product['name']
            ?.toLowerCase()
            .contains(query.toLowerCase()) ?? false)
            .toList();
      } else {
        filteredProducts = List.from(products);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.orange[600],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Welcome to XYZ!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
                icon: Icon(Icons.shopping_cart),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context,'/user');
                },
                icon: Icon(Icons.person),
              )
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: filterProducts,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 175,
              alignment: Alignment.center,
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.orange[600],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'Our Products:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
              child: Text(
                'No products found',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                : GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, filteredProducts[index]['route'] ?? '');
                  },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                          filteredProducts[index]['image'] ?? '',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        filteredProducts[index]['name'] ?? '',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}

