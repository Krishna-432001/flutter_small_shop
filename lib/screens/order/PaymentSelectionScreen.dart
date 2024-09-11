import 'package:flutter/material.dart';


import '../../models/Cart.dart';
import 'OrderConfirmScreen.dart';

class PaymentSelectionScreen extends StatefulWidget {
  final List<Cart> products;

  const PaymentSelectionScreen({super.key, required this.products});

  @override
  State<PaymentSelectionScreen> createState() => _PaymentSelectionScreenState();
}

class _PaymentSelectionScreenState extends State<PaymentSelectionScreen> {
  String? _selectedPaymentMethod;

  void _onPaymentMethodSelected(String? method) {
    setState(() {
      _selectedPaymentMethod = method;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Payment Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose your payment method:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Radio<String>(
                value: 'CASH',
                groupValue: _selectedPaymentMethod,
                onChanged: _onPaymentMethodSelected,
              ),
              title: const Text('CASH'),
            ),
            ListTile(
              leading: Radio<String>(
                value: 'UPI',
                groupValue: _selectedPaymentMethod,
                onChanged: _onPaymentMethodSelected,
              ),
              title: const Text('UPI'),
            ),
            ListTile(
              leading: Radio<String>(
                value: 'CARD',
                groupValue: _selectedPaymentMethod,
                onChanged: _onPaymentMethodSelected,
              ),
              title: const Text('CARD'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedPaymentMethod != null
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderConfirmScreen(
                      title: 'Order Confirmation',
                      products: widget.products,
                      paymentMethod: _selectedPaymentMethod!,
                    ),
                  ),
                );
              }
                  : null,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
