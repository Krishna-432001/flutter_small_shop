import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_small_shop/screens/CategoryScreen.dart';
import 'package:flutter_small_shop/screens/CountryListScreen.dart';
import 'package:flutter_small_shop/screens/LoginScreen.dart';
import 'package:flutter_small_shop/screens/PrivacyPolicyScreen.dart';
import 'package:flutter_small_shop/screens/RegisterScreen.dart';
import 'package:provider/provider.dart';
import '../models/Order.dart';
import '../services/auth.dart';
import 'AboutScreen.dart';
import 'BrandScreen.dart';
import 'ProfileDetailScreen.dart';
import 'order/OrderScreen.dart';
import 'cart/CartScreen.dart';
import 'product/ProductScreen.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    readToken();
  }

  void readToken() async {
    String? token = await storage.read(key: 'token');
    if (token != null) {
      Provider.of<Auth>(context, listen: false).tryToken(token: token);
      print("Read token: $token");
    } else {
      print("Token is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: Text('Home Screen')),
      drawer: Drawer(
        child: Consumer<Auth>(
          builder: (context, auth, child) {
            if (!auth.authenticated) {
              return ListView(
                children: [
                  ListTile(
                    title: Text('Login'),
                    leading: Icon(Icons.login),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen(title: 'Login Screen')),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Register'),
                    leading: Icon(Icons.app_registration),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen(title: 'Register')),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Country'),
                    leading: Icon(Icons.public),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CountryListScreen(title: 'Country')),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Category'),
                    leading: Icon(Icons.category),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CategoryScreen(title: 'Category')),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Brand'),
                    leading: Icon(Icons.branding_watermark),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BrandScreen(title: 'Brand')),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Product'),
                    leading: Icon(Icons.shopping_bag),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductScreen(title: 'Product')),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('About'),
                    leading: Icon(Icons.info),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Aboutscreen()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Privacy Policy'),
                    leading: Icon(Icons.privacy_tip),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PrivacyPolciyScreen()),
                      );
                    },
                  ),
                ],
              );
            } else {
              String name = auth.user?.name ?? 'Guest';
              String email = auth.user?.email ?? 'guest@example.com';

              return ListView(
                children: [
                  ListTile(
                    title: Text('Profile'),
                    leading: Icon(Icons.person),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  ProfileDetailScreen()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Cart'),
                    leading: Icon(Icons.shopping_cart),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartScreen(title: 'Cart')),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Order'),
                    leading: Icon(Icons.list),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderScreen(title: 'Order')),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Category'),
                    leading: Icon(Icons.category),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CategoryScreen(title: 'Category')),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Product'),
                    leading: Icon(Icons.shopping_bag),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductScreen(title: 'Product')),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.logout),
                    onTap: () {
                      Provider.of<Auth>(context, listen: false).logout();
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
