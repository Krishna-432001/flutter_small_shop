import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/Product.dart';
import '../../utils/Constants.dart';


import '../../models/Order.dart';
import '../cart/CartScreen.dart';
import 'ProductDetialScreen.dart';

class ProductScreen extends StatefulWidget {
  final String title;

  const ProductScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late List<Product> products = [];
  List<Product> favoriteProducts = []; // List to store favorite products
  List<Product> cartProducts = []; // List to store cart products

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse(Constants.BASE_URL + Constants.PRODUCT_ROUTE));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        setState(() {
          products = data.map((product) => Product.fromJson(product)).toList();
        });
      } else {
        throw Exception('Failed to load products: ' +
            Constants.BASE_URL +
            Constants.PRODUCT_ROUTE);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> onRefresh() async {
    await fetchData();
  }

  void toggleFavorite(Product product) {
    setState(() {
      if (favoriteProducts.contains(product)) {
        favoriteProducts.remove(product);
      } else {
        favoriteProducts.add(product);
      }
    });
  }

  void addToCart(Product product) {
    setState(() {
      if (!cartProducts.contains(product)) {
        cartProducts.add(product);
      }
    });
  }


  Widget _buildProductCard(Product product) {
    final bool isFavorite = favoriteProducts.contains(product);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    toggleFavorite(product);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    addToCart(product); // Add product to cart on button press
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 130,
              width: 130,
              child: Image.network(
                product.image_path,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              product.category,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.red,
              ),
            ),
            Text(
              '\$${product.price}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              fetchData();
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteScreen(favoriteProducts: favoriteProducts),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen( title: 'Cart'),
                ),
              );
            },
          ),

        ],
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: products.isEmpty
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (100 / 160),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return _buildProductCard(products[index]);
          },
        ),
      ),
    );
  }
}

class FavoriteScreen extends StatelessWidget {
  final List<Product> favoriteProducts;

  const FavoriteScreen({Key? key, required this.favoriteProducts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Products'),
      ),
      body: ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
              favoriteProducts[index].image_path,
              width: 50, // Adjust size as needed
              height: 50, // Adjust size as needed
              fit: BoxFit.cover,
            ),
            title: Text(favoriteProducts[index].name),
            subtitle: Text('\$${favoriteProducts[index].price}'),
          );
        },
      ),
    );
  }
}
