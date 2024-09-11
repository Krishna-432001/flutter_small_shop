import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/Product.dart';
import '../../services/CartProvider.dart';


class ProductDetailScreen extends StatelessWidget {
  final Product product;


  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.image_path,
                fit: BoxFit.cover,
                height: 200,
                width: 200,
              ),
            ),
            SizedBox(height: 16),
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Category: ${product.category}',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Brand: ${product.brand}',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              '\$${product.price}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false).addToCart(
                      cart: {
                        'product_id': product.id,
                        'product_name': product.name,
                        'qty': 1,
                      },
                      context: context,
                    );
                  },
                  child: Text('Add to Cart'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false).addToCart(
                      cart: {
                        'product_id': product.id,
                        'product_name': product.name,
                        'qty': 1,
                      },
                      context: context,
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => (order: order),
                    //   ),
                    // );
                  },
                  child: Text('Place Order'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
