import 'package:first_project/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_project/dairymilk_page.dart';
import 'package:first_project/home_page.dart';
import 'package:first_project/loading.dart';
import 'package:first_project/dairymilk165.dart';
import 'package:first_project/dairymilksilk.dart';
import 'package:first_project/dairymilkfn.dart';
import 'package:first_project/dairymilkbubbly.dart';
import 'package:first_project/perk.dart';
import 'package:first_project/perk-packet.dart';
import 'package:first_project/perk-double.dart';
import 'package:first_project/kitkat.dart';
import 'package:first_project/kitkatdark.dart';
import 'package:first_project/kitkatpacket.dart';
import 'package:first_project/kitkatcrispy.dart';
import 'package:first_project/munch.dart';
import 'package:first_project/munchnuts.dart';
import 'package:first_project/munchpacket.dart';
import 'package:first_project/munchmax.dart';
import 'package:first_project/fivestar.dart';
import 'package:first_project/fivestaroreo.dart';
import 'package:first_project/fivestarpacket.dart';
import 'package:first_project/fivestar3D.dart';
import 'package:first_project/cart_page.dart';
import 'cart_provider.dart';

class XYZ extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      title: "XYZ",
      initialRoute: '/home',
      routes: {
        // '/': (context) => LoadingPage(),
        '/home': (context) => HomePage(),
        '/dairymilk': (context) => DairymilkPage(),
        '/dairymilk165': (context) => Dairymilk165Page(),
        '/dairymilksilk': (context) => DairymilksilkPage(),
        '/dairymilkfn': (context) => DairymilkfnPage(),
        '/dairymilkbubbly': (context) => DairymilkbubblyPage(),
        '/perk': (context) => Perk(),
        '/perkpacket': (context) => Perkpacket(),
        '/perkdouble': (context) => Perkdouble(),
        '/kitkat': (context) => Kitkat(),
        '/kitkatdark': (context) => Kitkatdark(),
        '/kitkatpacket': (context) => Kitkatpacket(),
        '/kitkatcrispy': (context) => Kitkatcrispy(),
        '/munch': (context) => Munch(),
        '/munchnuts': (context) => Munchnuts(),
        '/munchpacket': (context) => Munchpacket(),
        '/munchmax': (context) => Munchmax(),
        '/fivestar': (context) => Fivestar(),
        '/fivestaroreo': (context) => Fivestaroreo(),
        '/fivestarpacket': (context) => Fivestarpacket(),
        '/fivestar3D': (context) => Fivestar3d(),
        '/cart': (context) => CartPage(),
        '/user': (context) => UserPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.teal, // Set primary color to teal
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.pink), // Set accent color to pink
      ),
    );
  }
}

void main () {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Cart(),
      child: XYZ(),
    ),
  );
}






