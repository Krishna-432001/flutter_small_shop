import 'package:flutter/material.dart';
import '../../models/Order.dart';


class OrderDetailScreen extends StatelessWidget {
  final Order order;

  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                order.image_Path,
                fit: BoxFit.cover,
                height: 200,
                width: 200,
              ),
            ),
            SizedBox(height: 16),
            Text(
              order.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Order ID: ${order.id}',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Price: \$${order.price}',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Logic for confirming the order can be added here
              },
              child: Text('Confirm Order'),
            ),
          ],
        ),
      ),
    );
  }
}
