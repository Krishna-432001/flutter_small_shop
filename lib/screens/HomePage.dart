import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

import 'BrandScreen.dart';
import 'HomeScreen.dart';
import 'cart/CartScreen.dart';
import 'product/ProductScreen.dart';

class MyCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage('assets/image1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage('assets/image2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage('assets/image3.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage('assets/image4.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage('assets/image5.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = FlutterSecureStorage();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    readToken();
  }

  void readToken() async {
    dynamic token = await storage.read(key: 'token');
    if (token != null) {
      String tokenString = token as String;
      Provider.of<Auth>(context, listen: false).tryToken(token: tokenString);
      print("Read token: $tokenString");
    } else {
      print("Token is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('SMALL SHOP')),
        backgroundColor: Colors.pink[200],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          HomeScreen(title: 'Home'),
          ProductScreen(title: 'Product'),
          BrandScreen(title: 'Brand'),
          CartScreen(title: 'cart')// Ensure CartScreen is properly instantiated
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() => currentIndex = value);
        },
        currentIndex: currentIndex,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Product",
            icon: Icon(Icons.category),
          ),
          BottomNavigationBarItem(
            label: "Brand",
            icon: Icon(Icons.branding_watermark),
          ),
          BottomNavigationBarItem(
            label: "Brand",
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
    );
  }
}
