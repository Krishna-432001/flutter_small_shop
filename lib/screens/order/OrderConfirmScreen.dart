import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../models/Cart.dart';
import '../../utils/Constants.dart';

class OrderConfirmScreen extends StatefulWidget {
  final String title;
  final List<Cart> products;
  final String paymentMethod;

  const OrderConfirmScreen({
    super.key,
    required this.title,
    required this.products,
    required this.paymentMethod,
  });

  @override
  State<OrderConfirmScreen> createState() => _OrderConfirmScreenState();
}

class _OrderConfirmScreenState extends State<OrderConfirmScreen> {
  // Create Storage
  final storage = FlutterSecureStorage();

  Future<void> confirmOrder() async {
    try {
      dynamic token = await this.storage.read(key: 'token');

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final body = json.encode({
        'order_items': widget.products.map((p) => p.toJson()).toList(),
        'payment_method': widget.paymentMethod,
      });

      // Send data to the server via API
      final response = await http.post(
        Uri.parse(Constants.BASE_URL + '/order/confirm'),
        headers: headers,
        body: body,
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 201) {
        // Handle successful order confirmation
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order confirmed successfully!'),
          ),
        );
      } else {
        // Handle error response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to confirm order'),
          ),
        );
      }
    } catch (e) {
      // Handle exception
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.products.fold(0, (sum, item) => sum + (item.price * item.qty));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('Payment Method: ${widget.paymentMethod}'),
            const SizedBox(height: 20),
            const Text(
              'Products:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              children: widget.products.map((product) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Qty:',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${product.qty}',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Price:',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )).toList(),
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Price:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: confirmOrder,
              child: const Text('Confirm Order'),
            ),
          ],
        ),
      ),
    );
  }
}
