import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_small_shop/screens/order/OrderDetialScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/Order.dart';
import '../../utils/Constants.dart';

import '../product/ProductScreen.dart';

class OrderScreen extends StatefulWidget {
  final String title;

  const OrderScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  // Create Storage
  final storage = new FlutterSecureStorage();

  late List<Order> orderItems = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      dynamic token = await this.storage.read(key: 'token');
      print(token);

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      final response = await http.get(
          headers: headers,
          Uri.parse(Constants.BASE_URL + Constants.ORDER_ROUTE)
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        setState(() {
          orderItems = data.map((item) => Order.fromJson(item)).toList();
        });
      } else {
        throw Exception('Failed to load order items');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void navigateToOrderDetailScreen(Order order) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderDetailScreen(order: order)),
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
            onPressed: fetchData,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: orderItems.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: orderItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.network(
                orderItems[index].image_Path,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
              ),
              title: Text(orderItems[index].name),
              onTap: () {
                navigateToOrderDetailScreen(orderItems[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
